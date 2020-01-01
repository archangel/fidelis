# frozen_string_literal: true

module Controllers
  module AuthorizableConcern
    extend ActiveSupport::Concern

    included do
      include Pundit
      include Controllers::ErrorableConcern

      after_action :verify_authorized, unless: :devise_controller?

      rescue_from Pundit::NotAuthorizedError, with: :render_error_unauthorized
    end

    protected

    def render_error_unauthorized(exception = nil)
      render_error('errors/unauthorized', :unauthorized, exception)
    end
  end
end
