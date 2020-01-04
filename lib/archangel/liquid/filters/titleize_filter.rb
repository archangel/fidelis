# frozen_string_literal: true

module Archangel
  module Liquid
    module Filters
      module TitleizeFilter
        def titleize(input)
          input&.titleize
        end
      end
    end
  end
end

Liquid::Template.register_filter(Archangel::Liquid::Filters::TitleizeFilter)
