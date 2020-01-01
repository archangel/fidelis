# frozen_string_literal: true

module Backend
  ##
  # link_to extension helpers
  #
  module LinkToHelper
    ##
    # "Back" button using `link_to`
    #
    # Example
    #   link_to_back(url: '/foo') =>
    #     <a href="/foo" role="button" class="btn btn-back">Back</a>
    #   link_to_back(url: '/foo', text: 'Bar') =>
    #     <a href="/foo" role="button" class="btn btn-back">Bar</a>
    #   link_to_back(url: '/foo', class: 'btn btn-foo') =>
    #     <a href="/foo" role="button" class="btn btn-foo">Back</a>
    #
    def link_to_back(options = {})
      options = options.reverse_merge(class: 'btn btn-info')

      options[:text] = options.delete(:text) || I18n.t(:back)

      link_to_custom(options)
    end

    ##
    # "Show" button using `link_to`
    #
    # Example
    #   link_to_show(url: '/foo') =>
    #     <a href="/foo" role="button" class="btn btn-show">Show</a>
    #   link_to_show(url: '/foo', text: 'Bar') =>
    #     <a href="/foo" role="button" class="btn btn-show">Bar</a>
    #   link_to_show(url: '/foo', class: 'btn btn-foo') =>
    #     <a href="/foo" role="button" class="btn btn-foo">Show</a>
    #
    def link_to_show(options = {})
      options = options.reverse_merge(class: 'btn btn-info')

      options[:text] = options.delete(:text) || I18n.t(:show)

      link_to_custom(options)
    end

    ##
    # "New" button using `link_to`
    #
    # Example
    #   link_to_new(url: '/foo') =>
    #     <a href="/foo" role="button" class="btn btn-new">New</a>
    #   link_to_new(url: '/foo', text: 'Bar') =>
    #     <a href="/foo" role="button" class="btn btn-new">Bar</a>
    #   link_to_new(url: '/foo', class: 'btn btn-foo') =>
    #     <a href="/foo" role="button" class="btn btn-foo">New</a>
    #
    def link_to_new(options = {})
      options = options.reverse_merge(class: 'btn btn-success')

      options[:text] = options.delete(:text) || I18n.t(:new)

      link_to_custom(options)
    end

    ##
    # "Edit" button using `link_to`
    #
    # Example
    #   link_to_edit(url: '/foo') =>
    #     <a href="/foo" role="button" class="btn btn-edit">Edit</a>
    #   link_to_edit(url: '/foo', text: 'Bar') =>
    #     <a href="/foo" role="button" class="btn btn-edit">Bar</a>
    #   link_to_edit(url: '/foo', class: 'btn btn-foo') =>
    #     <a href="/foo" role="button" class="btn btn-foo">Edit</a>
    #
    def link_to_edit(options = {})
      options = options.reverse_merge(class: 'btn btn-warning')

      options[:text] = options.delete(:text) || I18n.t(:edit)

      link_to_custom(options)
    end

    ##
    # "Delete" button using `link_to`
    #
    # Example
    #   link_to_delete(url: '/foo') =>
    #     <a href="/foo" role="button" data-method="delete" rel="nofollow"
    #        data-confirm="Are you sure?" class="btn btn-delete">Delete</a>
    #   link_to_delete(url: '/foo', text: 'Bar') =>
    #     <a href="/foo" role="button" data-method="delete" rel="nofollow"
    #        data-confirm="Are you sure?" class="btn btn-delete">Bar</a>
    #   link_to_delete(url: '/foo', class: 'btn btn-foo') =>
    #     <a href="/foo" role="button" data-method="delete" rel="nofollow"
    #        data-confirm="Are you sure?" class="btn btn-link">Delete</a>
    #
    def link_to_delete(options = {})
      options = options.reverse_merge(
        icon: 'fal fa-times-circle',
        class: 'btn btn-danger',
        method: :delete,
        data: { confirm: I18n.t(:are_you_sure) }
      )

      options[:text] = options.delete(:text) || I18n.t(:delete)

      link_to_custom(options)
    end

    ##
    # Custom button using `link_to`
    #
    # Example
    #   link_to_custom(url: '/foo', text: 'Bar') =>
    #     <a href="/foo" role="button" class="btn btn-link">Bar</a>
    #   link_to_custom(url: '/foo', text: 'Bar', class: 'btn btn-foo') =>
    #     <a href="/foo" role="button" class="btn btn-foo">Bar</a>
    #
    def link_to_custom(options = {})
      url = options.delete(:url) || '#'
      text = options.delete(:text)

      options = options.reverse_merge(
        role: 'button', class: 'btn btn-link',
        title: text,
        aria: { label: text }
      )

      link_to(text, url, options)
    end
  end
end
