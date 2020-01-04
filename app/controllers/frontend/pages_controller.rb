# frozen_string_literal: true

module Frontend
  class PagesController < FrontendController
    before_action :set_resource_content, only: %i[show]
    before_action :assign_resource_meta_tags, if: -> { request.get? },
                                              unless: -> { request.xhr? }

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

    ##
    # Assign meta tags to view
    #
    def assign_resource_meta_tags
      assign_meta_tags(resource_meta_tags)
    end

    ##
    # Meta tags for the page
    #
    # @return [Object] the page meta tags
    #
    def resource_meta_tags
      meta_tags = [
        current_site.metatags,
        @page.metatags
      ].flatten.inject({}) do |tags, metatag|
        tags.merge(metatag.name => metatag.content)
      end

      meta_tags.merge(title: @page.title)
    end

    def render_or_redirect_to_homepage
      return redirect_to_homepage if current_site.homepage_redirect?

      render_error_not_found
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

      RenderService.call(@page.content, variables)
    end

    ##
    # Render content with design
    #
    # @return [String] the rendered template
    #
    def rendered_design_content
      content = rendered_content
      variables = default_render_assign.merge(content_for_layout: content)

      DesignRenderService.call(@page.design, variables)
    end

    def default_render_assign
      request_render_assign.merge(
        current_page: request.fullpath,
        page: PageDrop.new(@page),
        site: SiteDrop.new(current_site)
      )
    end

    def request_render_assign
      {
        request: {
          domain: request.domain,
          fullpath: request.fullpath,
          host: request.host_with_port,
          path: request.path,
          protocol: request.protocol,
          url: "#{request.protocol}#{request.host_with_port}"
        }
      }
    end
  end
end
