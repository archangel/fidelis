# frozen_string_literal: true

module Backend
  class ProfilesController < BackendController
    include Controllers::Html::ResourcefulConcern
    include Controllers::SkipAuthorizableConcern

    def update
      profile = resource_content
      empty_password_params if resource_params.fetch(:password, nil).blank?
      successfully_updated = if needs_password?
                               profile.update(resource_params)
                             else
                               profile.update_without_password(resource_params)
                             end

      bypass_sign_in(profile) if successfully_updated

      respond_with profile, location: -> { location_after_update }
    end

    protected

    def permitted_attributes
      %w[
        name password password_confirmation username
        avatar remove_avatar
      ]
    end

    def resource_content
      @profile = current_user
    end

    def location_after_save
      backend_profile_path
    end

    private

    def empty_password_params
      %i[password password_confirmation].each { |k| resource_params.delete(k) }
    end

    def needs_password?
      resource_params.fetch(:password, nil).present?
    end

    def flash_interpolation_options
      { resource_name: 'Profile' }
    end
  end
end
