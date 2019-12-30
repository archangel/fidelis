# frozen_string_literal: true

module Backend
  class SitesController < BackendController
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      %w[locale name theme]
    end

    def resource_content
      @site = Site.current
    end

    def location_after_save
      backend_site_path
    end
  end
end
