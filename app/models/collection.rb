# frozen_string_literal: true

class Collection < ApplicationRecord
  acts_as_paranoid

  before_validation :parameterize_slug

  after_destroy :column_reset

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  has_many :entries, -> { order(position: :asc) }, dependent: :destroy,
                                                   inverse_of: :collection
  has_many :fields, -> { order(position: :asc) }, dependent: :destroy,
                                                  inverse_of: :collection

  accepts_nested_attributes_for :fields, reject_if: :all_blank,
                                         allow_destroy: true

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
