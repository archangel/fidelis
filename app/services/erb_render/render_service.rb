# frozen_string_literal: true

require 'erb'
require 'ostruct'

module ErbRender
  class RenderService
    ##
    # Variable assignments
    #
    attr_reader :assigns

    ##
    # Template to Liquidize
    #
    attr_reader :template

    ##
    # Liquid renderer
    #
    # @param template [String] the Liquid template
    # @param assigns [Object] the variable assignments
    #
    def initialize(template, assigns = {})
      @template = template
      @assigns = assigns
    end

    ##
    # Render the Liquid content
    #
    # @param template [String] the content
    # @param assigns [Hash] the local variables
    # @param options [Hash] the options
    # @return [String] the rendered content
    #
    def self.call(template, assigns = {})
      new(template, assigns).call
    end

    ##
    # Render the Liquid content
    #
    # @return [String] the rendered content
    #
    def call
      b = binding

      assigns.each { |k, v| b.local_variable_set(k, v) }

      ERB.new(template, trim_mode: '%<>').result(b)
    end
  end
end
