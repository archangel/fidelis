# frozen_string_literal: true

class Design < ApplicationRecord
  acts_as_paranoid

  validates :content, presence: true
  validates :name, presence: true
  validates :partial, inclusion: { in: [true, false] }

  belongs_to :parent, -> { where(partial: false) },
             class_name: 'Design',
             inverse_of: false,
             optional: true
end
