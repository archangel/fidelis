# frozen_string_literal: true

module Frontend
  ##
  # Frontend homepages controller
  #
  # Extends Frontend/PagesController to provide functionality
  #
  class HomepagesController < PagesController
    protected

    ##
    # Find and assign resource to the view
    #
    def set_resource_content
      @page = Page.homepage.first!
    end

    ##
    # Override. Do not redirect. This is the homepage.
    #
    # @return [Boolean] false
    #
    def redirect_to_homepage?
      false
    end
  end
end
