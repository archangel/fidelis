# frozen_string_literal: true

class PageDrop < Liquid::Drop
  attr_reader :object

  def initialize(resource)
    @object = resource
  end

  delegate :homepage, :published_at, :slug, :title, to: :object

  def id
    object.id.to_s
  end

  def permalink
    "/#{object.permalink}"
  end

  def timestamp
    return if object.published_at.blank?

    object.published_at.strftime('%s')
  end
end
