# frozen_string_literal: true

require 'letter_avatar/has_avatar'

class User < ApplicationRecord
  include LetterAvatar::HasAvatar

  extend Devise::Models

  acts_as_paranoid

  attr_accessor :remove_avatar

  typed_store :preferences, coder: JSON do |preference|
    preference.string :locale
  end

  after_save :purge_avatar, if: :remove_avatar

  devise :confirmable, :database_authenticatable, :invitable, :lockable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  has_one_attached :avatar

  validates :avatar, allow_blank: true,
                     attached: true,
                     size: { more_than: 0.bytes, less_than: 5.megabytes },
                     content_type: %i[gif jpeg jpg png]
  validates :email, presence: true, email: { message: :email }, uniqueness: true
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  private

  def purge_avatar
    avatar.purge_later
  end
end
