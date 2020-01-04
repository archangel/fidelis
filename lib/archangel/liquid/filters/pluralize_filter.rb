# frozen_string_literal: true

module Archangel
  module Liquid
    module Filters
      module PluralizeFilter
        def pluralize(input)
          input&.pluralize
        end
      end
    end
  end
end

Liquid::Template.register_filter(Archangel::Liquid::Filters::PluralizeFilter)
