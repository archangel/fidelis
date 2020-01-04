# frozen_string_literal: true

class SiteDrop < Liquid::Drop
  attr_reader :object

  def initialize(resource)
    @object = resource
  end

  delegate :name, :theme, :locale, to: :object

  def logo
    # helpers.url_for('logo.png') unless object.logo.attached?
    #
    # helpers.url_for(object.logo)

    'logo.png'
  end

  # private
  #
  # def helpers
  #   ::Rails.application.routes.url_helpers
  # end
end
