# frozen_string_literal: true

module Backend
  class DesignsController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      %w[content name parent_id partial]
    end

    def resources_content
      @designs = Design.order(name: :asc)
                       .page(page_num).per(per_page)
    end

    def resource_content
      resource_id = params.fetch(:id)

      @design = Design.find_by!(id: resource_id)
    end

    def resource_new_content
      @design = Design.new(resource_new_params)
    end
  end
end
