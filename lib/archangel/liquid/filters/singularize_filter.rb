# frozen_string_literal: true

module Archangel
  module Liquid
    module Filters
      module SingularizeFilter
        def singularize(input)
          input&.singularize
        end
      end
    end
  end
end

Liquid::Template.register_filter(Archangel::Liquid::Filters::SingularizeFilter)
