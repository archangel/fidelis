# frozen_string_literal: true

module ApplicationHelper
  ##
  # Frontend resource permalink.
  #
  # Same as `frontend_page_path` except it prints out nested resources in a
  # nice way.
  #
  # Example
  #   <%= frontend_resource_path('amazing/grace') %> #=> /amazing/grace
  #   <%= frontend_resource_path(@page) %> #=> /amazing/grace
  #
  # @return [String] frontend resource permalink
  #
  def frontend_resource_path(resource)
    permalink_path = proc do |permalink|
      frontend_page_path(permalink).gsub('%2F', '/')
    end

    return permalink_path.call(resource) unless resource.class == Page
    return frontend_root_path if resource.homepage?

    permalink_path.call(resource.permalink)
  end
end
