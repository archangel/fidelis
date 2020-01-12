# frozen_string_literal: true

require 'archangel/liquid/tags/application_tag'

module Archangel
  module Liquid
    module Tags
      ##
      # Asset custom tag for Liquid
      #
      # Example
      #   {% asset 'my-asset.png' %} #=>
      #     <img src="path/to/my-asset.png" alt="my-asset.png">
      #   {% asset 'my-asset.png' size:'medium' %} #=>
      #     <img src="path/to/medium_my-asset.png" alt="my-asset.png">
      #   {% asset 'my-asset.png' alt:'My image' class:'center' %} #=>
      #     <img src="path/to/my-asset.png" alt="My image" class="center">
      #
      class AssetTag < ApplicationTag
        ##
        # Asset for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = ASSET_ATTRIBUTES_SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, I18n.t('liquid.errors.syntax.asset')
          end

          @key = ::Liquid::Variable.new(match[:asset], options).name
          @attributes = {}

          build_attributes(match[:attributes])
        end

        ##
        # Render the Asset
        #
        # @param context [Object] the Liquid context
        # @return [String] the rendered Asset
        #
        def render(_context)
          return if key.blank?

          asset = load_asset_for_key

          return if asset.blank?

          image_asset(asset)
        end

        protected

        attr_reader :attributes, :height, :key, :resize, :width

        def build_attributes(attrs)
          attrs.scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end

          @width = attributes.fetch(:width, nil)
          @height = attributes.fetch(:height, @width)

          %i[width height].each { |item| @attributes.delete(item) }
        end

        def load_asset_for_key
          Asset.find_by(name: key)
        end

        def image_asset(asset)
          params = {
            alt: asset.name
          }.merge(attributes).merge(
            src: image_asset_builder(asset.file)
          ).compact.reject { |_, value| value.blank? }

          tag('img', params)
        end

        def image_asset_builder(file)
          return returned_image_asset(file) if width.blank? && height.blank?

          sized_image_asset(file)
        end

        def returned_image_asset(file)
          ::Rails.application.routes.url_helpers.rails_blob_url(file)
        end

        def sized_image_asset(file)
          ::Rails.application.routes.url_helpers.rails_representation_url(
            file.variant(resize_to_limit: [width, height]).processed
          )
        end
      end
    end
  end
end

Liquid::Template.register_tag('asset', Archangel::Liquid::Tags::AssetTag)
