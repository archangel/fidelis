# frozen_string_literal: true

module Backend
  class EntriesController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    before_action :parent_resource_content

    protected

    def permitted_attributes
      fields = @collection.fields.map(&:slug).map(&:to_sym)

      fields + %i[published_at]
    end

    def parent_resource_content
      collection_id = params.fetch(:collection_id)

      @collection = Collection.find_by!(id: collection_id)
    end

    def resources_content
      @entries = Entry.where(collection: @collection)
                      .page(page_num).per(per_page)

      authorize @entries
    end

    def resource_content
      resource_id = params.fetch(:id)

      @entry = Entry.where(collection: @collection).find_by!(id: resource_id)

      authorize @entry
    end

    def resource_new_content
      @entry = Entry.where(collection: @collection).new(nil)

      if action_name.to_sym == :create
        @collection.fields.map(&:slug).each do |field|
          @entry.assign_attributes(field => resource_params.fetch(field, nil))
        end
      end

      authorize @entry
    end

    def resource_scope
      :collection_entry
    end

    def location_after_save
      backend_collection_entries_path(@collection)
    end
  end
end
