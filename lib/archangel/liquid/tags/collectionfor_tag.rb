# frozen_string_literal: true

require 'archangel/liquid/tags/application_tag'

module Archangel
  module Liquid
    module Tags
      ##
      # Collection custom tag for Liquid to set a variable for Collections
      #
      # Example
      #   {% collectionfor item in 'my-collection' %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endcollectionfor %}
      #
      #   {% collectionfor item in 'my-collection' limit:5 offset:25 %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endcollectionfor %}
      #
      #   {% collectionfor item in 'my-collection' reversed %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endcollectionfor %}
      #
      #   {% collectionfor item in 'my-collection' %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% else %}
      #      There is nothing in the collection.
      #   {% endcollectionfor %}
      #
      #   {% collectionfor item in 'my-collection' %}
      #     {{ forloop.name }}
      #     {{ forloop.length }}
      #     {{ forloop.index }}
      #     {{ forloop.index0 }}
      #     {{ forloop.rindex }}
      #     {{ forloop.rindex0 }}
      #     {{ forloop.first }}
      #     {{ forloop.last }}
      #     {{ forloop.parentloop }}
      #   {% endcollectionfor %}
      #
      class CollectionforTag < ::Liquid::For
        protected

        def collection_segment(context)
          offsets = context.registers[:for] ||= {}
          offset = context.evaluate(@from).to_i
          limit = context.evaluate(@limit)

          segment = load_collection(offset, limit)

          segment.reverse! if @reversed

          offsets[@name] = offset + segment.length

          segment
        end

        def load_collection(offset, limit)
          entries = load_collection_entries_for(offset, limit)

          entries.each_with_object([]) do |entry, collection|
            collection <<
              default_values_for(entry).reverse_merge(entry['value'])
          end
        end

        def load_collection_entries_for(offset, limit)
          collection = Collection.find_by(slug: @collection_name)

          return [] if collection.blank?

          offset = 1 if offset.zero?
          limit = 12 if limit.blank?

          Entry.available
               .where(collection: collection)
               .page(offset).per(limit)
               .map(&:attributes)
        rescue StandardError
          []
        end

        def default_values_for(entry)
          { 'id' => entry['id'] }
        end
      end
    end
  end
end

Liquid::Template.register_tag('collectionfor',
                              Archangel::Liquid::Tags::CollectionforTag)
