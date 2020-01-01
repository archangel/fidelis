# frozen_string_literal: true

module Backend
  module Users
    class SessionsController < Devise::SessionsController
      protected

      def after_sign_in_path_for(resource_or_scope)
        stored_location_for(resource_or_scope) || backend_root_path
      end

      def after_sign_out_path_for(_resource_or_scope)
        new_user_session_path
      end
    end
  end
end
