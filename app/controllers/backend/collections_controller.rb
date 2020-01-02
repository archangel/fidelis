# frozen_string_literal: true

module Backend
  class CollectionsController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      [
        :name, :slug,
        fields_attributes: %i[id _destroy classification label required slug]
      ]
    end

    def resources_content
      @collections = Collection.order(name: :asc).page(page_num).per(per_page)

      authorize @collections
    end

    def resource_content
      resource_id = params.fetch(:id)

      resource = Collection.find_by!(id: resource_id)
      resource.fields.build if action_name == 'edit' && resource.fields.blank?

      authorize @collection = resource
    end

    def resource_new_content
      resource = Collection.new(resource_new_params)
      resource.fields.build if action_name == 'new' && resource.fields.blank?

      authorize @collection = resource
    end
  end
end
