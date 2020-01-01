# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html, :json

  include Controllers::ErrorableConcern

  helper_method :current_site

  before_action :set_locale

  protected

  def current_site
    @current_site ||= Site.current
  end

  def set_locale
    locale = session[:locale].to_s.strip.to_sym

    I18n.locale = locale_for(locale)
  end

  private

  def locale_for(locale)
    I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end
end
