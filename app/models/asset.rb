# frozen_string_literal: true

class Asset < ApplicationRecord
  acts_as_paranoid

  has_one_attached :file

  validates :file, presence: true,
                   attached: true,
                   size: { more_than: 0.bytes, less_than: 5.megabytes },
                   content_type: %i[gif jpeg jpg png]
  validates :name, presence: true

  validate :valid_file_name

  protected

  def valid_file_name
    return if /^[\w-]+\.[A-Za-z]{2,}$/.match?(name)

    errors.add(:name, I18n.t('errors.messages.asset_invalid_name'))
  end
end
