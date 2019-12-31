# frozen_string_literal: true

class Site < ApplicationRecord
  validates :locale, presence: true,
                     inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :name, presence: true
  validates :theme, inclusion: { in: %w[default] }, allow_blank: true

  ##
  # Current site
  #
  # @return [Object] first available site as current site
  #
  def self.current
    first_or_create do |record|
      record.name = 'Archangel'
      record.theme = 'default'
      record.locale = I18n.default_locale.to_s
    end
  end
end
