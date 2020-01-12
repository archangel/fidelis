# frozen_string_literal: true

class Widget < ApplicationRecord
  acts_as_paranoid

  before_validation :parameterize_slug

  after_destroy :column_reset

  validates :content, presence: true
  validates :name, presence: true
  validates :slug, presence: true, slug: true, uniqueness: true

  validate :valid_liquid_content

  belongs_to :design, -> { where(partial: true) },
             inverse_of: false,
             optional: true

  protected

  def parameterize_slug
    which_to_slug = slug.presence || name

    self.slug = which_to_slug.to_s.downcase.parameterize
  end

  def column_reset
    now = Time.current.to_i

    self.slug = "#{now}_#{slug}"

    save
  end

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
