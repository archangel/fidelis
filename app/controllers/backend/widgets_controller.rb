# frozen_string_literal: true

module Backend
  class WidgetsController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      %w[content design_id name slug]
    end

    def resources_content
      @widgets = Widget.order(name: :asc)
                       .page(page_num).per(per_page)
    end

    def resource_content
      resource_id = params.fetch(:id)

      @widget = Widget.find_by!(id: resource_id)
    end

    def resource_new_content
      @widget = Widget.new(resource_new_params)
    end
  end
end
