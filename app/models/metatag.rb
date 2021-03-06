# frozen_string_literal: true

class Metatag < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { scope: %i[metatagable_type metatagable_id] }

  belongs_to :metatagable, polymorphic: true
end
