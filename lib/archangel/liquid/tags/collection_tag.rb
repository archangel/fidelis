# frozen_string_literal: true

require 'archangel/liquid/tags/application_tag'

module Archangel
  module Liquid
    module Tags
      ##
      # Collection custom tag for Liquid to set a variable for Collections
      #
      # Example
      #   {% collection things = 'my-collection' %}
      #   {% for item in things %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endfor %}
      #
      #   {% collection things = 'my-collection' limit:5 offset:25 %}
      #   {% for item in things %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endfor %}
      #
      class CollectionTag < ApplicationTag
        ##
        # Regex for tag syntax
        #
        SYNTAX = /
          (?<key>#{::Liquid::VariableSignature}+)
          \s*
          =
          \s*
          (?<value>#{::Liquid::QuotedFragment}+)
          \s*
          (?<attributes>.*)
          \s*
        /omx.freeze

        ##
        # Collection for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError,
                  I18n.t('liquid.errors.syntax.collection')
          end

          @key = match[:key]
          @value = ::Liquid::Variable.new(match[:value], options).name
          @attributes = {}

          match[:attributes].scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the collection object
        #
        # @param context [Object] the Liquid context
        # @return [Hash] the object
        #
        def render(context)
          val = load_collection

          context.scopes.last[key] = val
          context.resource_limits.assign_score << assign_score_of(val)

          ''
        end

        def blank?
          true
        end

        protected

        attr_reader :attributes, :key, :value

        def load_collection
          items = load_collection_for(value)

          items.each_with_object([]) do |item, collection|
            collection <<
              default_values(item).reverse_merge(item.fetch('value'))
          end
        end

        def load_collection_for(slug)
          collection = Collection.find_by(slug: slug)

          return [] if collection.blank?

          Entry.where(collection: collection)
               .available
               .page(attributes.fetch(:offset, 1))
               .per(attributes.fetch(:limit, 12))
               .map(&:attributes)
        rescue StandardError
          []
        end

        def assign_score_of(val)
          return val.length if val.instance_of?(String)

          return 1 unless val.instance_of?(Array) || val.instance_of?(Hash)

          val.inject(1) { |sum, item| sum + assign_score_of(item) }
        end

        def default_values(entry)
          { 'id' => entry.fetch('id', 0) }
        end
      end
    end
  end
end

Liquid::Template.register_tag('collection',
                              Archangel::Liquid::Tags::CollectionTag)
