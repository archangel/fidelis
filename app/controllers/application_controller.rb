# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html, :json

  helper_method :current_site

  before_action :set_locale

  rescue_from AbstractController::ActionNotFound,
              ActiveRecord::RecordNotFound,
              ActionView::MissingTemplate, with: :render_404_error

  protected

  def current_site
    @current_site ||= Site.current
  end

  def set_locale
    locale = session[:locale].to_s.strip.to_sym

    I18n.locale = locale_for(locale)
  end

  ##
  # Error 404
  #
  # Render a 404 (not found) error response
  #
  # Response
  #   {
  #     "status": 404,
  #     "error": "Page not found"
  #   }
  #
  # @param exception [Object] error object
  # @return [String] response
  #
  def render_404_error(exception = nil)
    render_error('errors/error_404', :not_found, exception)
  end

  ##
  # Error renderer
  #
  # Formats
  #   HTML, JSON
  #
  # Response
  #   {
  #     "status": XYZ,
  #     "error": "Error message"
  #   }
  #
  # @param path [String] error template path
  # @param status [String,Symbol] response status code
  # @param _exception [Object] error object
  # @return [String] response
  #
  def render_error(path, status, _exception = nil)
    respond_to do |format|
      format.html { render(template: path, status: status) }
      format.json { render(template: path, status: status, layout: false) }
    end
  end

  private

  def locale_for(locale)
    I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end
end
