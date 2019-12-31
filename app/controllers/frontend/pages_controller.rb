# frozen_string_literal: true

module Frontend
  class PagesController < FrontendController
    before_action :set_resource_content, only: %i[show]

    def show
      return render_or_redirect_to_homepage if redirect_to_homepage?

      respond_to do |format|
        format.html do
          render inline: rendered_design_content, layout: 'application'
        end
        format.json do
          render(template: 'frontend/pages/show', layout: false)
        end
      end
    end

    protected

    ##
    # Find and assign resource to the view
    #
    def set_resource_content
      resource_permalink = params.fetch(:permalink, nil)

      @page = Page.available.find_by!(permalink: resource_permalink)
    end

    def render_or_redirect_to_homepage
      render_error('errors/error_404', :not_found)
    end

    ##
    # Check to redirect to homepage root permalink
    #
    # @return [Boolean] redirect or not
    #
    def redirect_to_homepage?
      @page.homepage?
    end

    ##
    # Redirect to homepage root permalink is page is marked as the homepage
    #
    def redirect_to_homepage
      redirect_to frontend_root_path, status: :moved_permanently
    end

    ##
    # Render content
    #
    # @return [String] the rendered content
    #
    def rendered_content
      variables = default_render_assign

      ErbRender::RenderService.call(@page.content, variables)
    end

    ##
    # Render content with design
    #
    # @return [String] the rendered template
    #
    def rendered_design_content
      content = rendered_content
      variables = default_render_assign.merge(content_for_layout: content)

      ErbRender::DesignRenderService.call(@page.design, variables)
    end

    def default_render_assign
      {
        current_page: request.fullpath,
        page: @page.as_json,
        site: {}.as_json
      }
    end
  end
end
