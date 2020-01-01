# frozen_string_literal: true

module Controllers
  module ErrorableConcern
    extend ActiveSupport::Concern

    included do
      rescue_from AbstractController::ActionNotFound,
                  ActiveRecord::RecordNotFound,
                  ActionController::RoutingError, with: :render_error_not_found
    end

    protected

    def render_error_not_found(exception = nil)
      render_error('errors/not_found', :not_found, exception)
    end

    def render_error(path, status, _exception = nil)
      respond_to do |format|
        format.html { render(template: path, status: status) }
        format.json { render(template: path, status: status, layout: false) }
      end
    end
  end
end
