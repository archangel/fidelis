# frozen_string_literal: true

module Models
  ##
  # Model publish concern
  #
  module PublishableConcern
    extend ActiveSupport::Concern

    included do
      validates :published_at, allow_blank: true, date: true

      scope :published, (lambda do
        where.not(published_at: nil)
      end)
    end

    ##
    # Check if resource is published.
    #
    # Future publication date is also considered published. This will return
    # true if there is any published date avaialable; past, present and future.
    #
    # @return [Boolean] if published
    #
    def published?
      published_at.present?
    end
  end
end
