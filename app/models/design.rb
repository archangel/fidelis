# frozen_string_literal: true

class Design < ApplicationRecord
  acts_as_paranoid

  validates :content, presence: true
  validates :name, presence: true
  validates :partial, inclusion: { in: [true, false] }

  validate :valid_liquid_content

  belongs_to :parent, -> { where(partial: false) },
             class_name: 'Design',
             inverse_of: false,
             optional: true

  protected

  def valid_liquid_content
    return if valid_liquid_content?

    errors.add(:content, I18n.t('liquid.errors.invalid'))
  end

  private

  def valid_liquid_content?
    ::Liquid::Template.parse(content)

    true
  rescue ::Liquid::SyntaxError
    false
  end
end
