# frozen_string_literal: true

class Widget < ApplicationRecord
  before_validation :parameterize_slug

  after_destroy :column_reset

  validates :content, presence: true
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

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
end
