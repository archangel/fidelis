# frozen_string_literal: true

class Page < ApplicationRecord
  before_validation :parameterize_slug

  before_save :build_page_permalink

  after_save :homepage_reset

  after_destroy :column_reset

  validates :content, presence: true
  validates :homepage, inclusion: { in: [true, false] }
  validates :permalink, uniqueness: true
  validates :slug, presence: true, uniqueness: { scope: %i[parent_id] }
  validates :title, presence: true

  validate :within_valid_path

  belongs_to :design, -> { where(partial: false) },
             inverse_of: false,
             optional: true
  belongs_to :parent, class_name: 'Page', optional: true

  scope :homepage, (-> { where(homepage: true) })

  protected

  def within_valid_path
    return if within_valid_path?

    errors.add(:slug, 'contains a restricted path')
  end

  def parameterize_slug
    which_to_slug = slug.presence || title

    self.slug = which_to_slug.to_s.downcase.parameterize
  end

  def build_page_permalink
    parent_permalink = parent.blank? ? nil : parent.permalink

    self.permalink = [parent_permalink, slug].compact.join('/')
  end

  def homepage_reset
    return unless homepage?

    self.class
        .where(homepage: true)
        .where.not(id: id)
        .update(homepage: false)
  end

  def column_reset
    now = Time.current.to_i

    self.slug = "#{now}_#{slug}"

    save
  end

  def within_valid_path?
    reserved_paths.reject(&:empty?).each do |path|
      return false if %r{^#{slug}/?}.match?(path)
    end
  end

  def reserved_paths
    %w[admin]
  end
end
