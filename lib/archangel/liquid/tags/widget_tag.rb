# frozen_string_literal: true

require 'archangel/liquid/tags/application_tag'

module Archangel
  module Liquid
    module Tags
      ##
      # Widget custom tag for Liquid
      #
      # Example
      #   {% widget "widget-name" %}
      #   {% widget 'widget-name' %}
      #   {% widget widget-name %}
      #
      class WidgetTag < ApplicationTag
        ##
        # Widget for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = SLUG_SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, I18n.t('liquid.errors.syntax.widget')
          end

          @slug = ::Liquid::Variable.new(match[:slug], options).name
        end

        ##
        # Render the Widget
        #
        # @param context [Object] the Liquid context
        # @return [String] the rendered Widget
        #
        def render(context)
          return if slug.blank?

          widget = load_widget_for_slug

          return if widget.blank?

          rendered_widget = render_widget(widget.content,
                                          context.environments.first)

          if widget.design.present?
            rendered_widget = render_designed_widget(widget.design,
                                                     rendered_widget)
          end

          rendered_widget
        end

        protected

        attr_reader :slug

        def load_widget_for_slug
          Widget.find_by(slug: slug)
        end

        def render_widget(content, assigns)
          RenderService.call(content, assigns)
        end

        def render_designed_widget(design_content, widget_content)
          DesignRenderService.call(design_content,
                                   content_for_layout: widget_content)
        end
      end
    end
  end
end

Liquid::Template.register_tag('widget', Archangel::Liquid::Tags::WidgetTag)
