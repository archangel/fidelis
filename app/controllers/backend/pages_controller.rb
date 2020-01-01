# frozen_string_literal: true

module Backend
  class PagesController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      [
        :content, :design_id, :homepage, :parent_id, :published_at, :slug,
        :title,
        metatags_attributes: %i[id _destroy name content]
      ]
    end

    def resources_content
      @pages = Page.order(title: :asc)
                   .page(page_num).per(per_page)

      authorize @pages
    end

    def resource_content
      resource_id = params.fetch(:id)

      @page = Page.find_by!(id: resource_id)

      authorize @page
    end

    def resource_new_content
      @page = Page.new(resource_new_params)

      authorize @page
    end
  end
end
