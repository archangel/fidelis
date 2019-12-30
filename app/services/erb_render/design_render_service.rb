# frozen_string_literal: true

module ErbRender
  class DesignRenderService < ErbRender::RenderService
    ##
    # Render the content for template
    #
    # @return [String] the rendered content for template
    #
    def call
      template_content = build_template(template)

      b = binding

      b.local_variable_set(template_tag_variable,
                           (template.blank? ? '' : template.content))
      assigns.each { |k, v| b.local_variable_set(k, v) }

      ERB.new(template_content, trim_mode: '%<>').result(b)
    end

    def template_tag_opener
      '<%='
    end

    def template_tag_variable
      'content_for_layout'
    end

    def template_tag_closer
      '%>'
    end

    protected

    def build_template(template)
      template_content = current_template_content(template)

      unless Regexp.new(escaped_template_tag_regex).match?(template_content)
        template_content << full_template_tag_variable
      end

      template_content
    end

    def current_template_content(template)
      return full_template_tag_variable if template.blank?

      template.content
    end

    def full_template_tag_variable
      [
        template_tag_opener, template_tag_variable, template_tag_closer
      ].join(' ')
    end

    def escaped_template_tag_regex
      [
        Regexp.escape(template_tag_opener),
        template_tag_variable,
        Regexp.escape(template_tag_closer)
      ].join('\s*')
    end
  end
end
