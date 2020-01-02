# frozen_string_literal: true

class Field < ApplicationRecord
  CLASSIFICATIONS = %w[boolean email integer string url].freeze

  acts_as_paranoid

  acts_as_list scope: :collection_id,
               top_of_list: 0,
               add_new_at: :bottom

  validates :classification, presence: true,
                             inclusion: { in: CLASSIFICATIONS }
  validates :collection_id, presence: true, on: :update
  validates :label, presence: true
  validates :required, inclusion: { in: [true, false] }
  validates :slug, presence: true, uniqueness: { scope: :collection_id }

  belongs_to :collection
end
