# frozen_string_literal: true

class Entry < ApplicationRecord
  include Models::EntryValidatableConcern
  include Models::PublishableConcern

  acts_as_paranoid

  acts_as_list scope: :collection_id, top_of_list: 0, add_new_at: :top

  validates :collection_id, presence: true

  belongs_to :collection

  default_scope { order(position: :asc) }

  scope :available, (lambda do
    published.where('published_at <= ?', Time.current)
  end)

  protected

  def resource_value_fields
    return [] if try(:collection).try(:fields).blank?

    collection.fields
  end
end
