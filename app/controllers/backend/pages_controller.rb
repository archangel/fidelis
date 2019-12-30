# frozen_string_literal: true

module Backend
  class PagesController < BackendController
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      %w[content design_id homepage parent_id published_at slug title]
    end

    def resources_content
      @pages = Page.all
    end

    def resource_content
      resource_id = params.fetch(:id)

      @page = Page.find_by(id: resource_id)
    end

    def resource_new_content
      @page = Page.new(resource_new_params)
    end
  end
end
