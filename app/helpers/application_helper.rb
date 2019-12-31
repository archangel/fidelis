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

  ##
  # Site locale. Default `en`
  #
  # Example
  #   <%= locale %> #=> "en"
  #
  # @return [String] site locale
  #
  def locale
    current_site.locale || I18n.default_locale.to_s
  end

  ##
  # Language direction ("ltr" or "rtl"). Default `ltr`
  #
  # Example
  #   <%= text_direction %> #=> "ltr"
  #
  # @return [String] language direction
  #
  def text_direction
    'ltr'
  end
end
