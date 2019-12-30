# frozen_string_literal: true

module Controllers
  module Html
    module ResourcefulConcern
      extend ActiveSupport::Concern

      def index
        resources = resources_content

        respond_with resources
      end

      def show
        resource = resource_content

        respond_with resource
      end

      def new
        resource = resource_new_content

        respond_with resource
      end

      def create
        resource = resource_new_content

        resource.save if resource.present?

        respond_with resource, location: -> { location_after_create }
      end

      def edit
        resource = resource_edit_content

        respond_with resource
      end

      def update
        resource = resource_edit_content

        resource.update(resource_params_edit) if resource.present?

        respond_with resource, location: -> { location_after_update }
      end

      def destroy
        resource = resource_destroy_content

        resource.destroy if resource.present?

        respond_with resource, location: -> { location_after_destroy }
      end

      protected

      def resources_content
        []
      end

      def resource_content
        {}
      end

      def resource_new_content
        nil
      end

      def resource_edit_content
        resource_content
      end

      def resource_destroy_content
        resource_content
      end

      ##
      # Controller name (plurel)
      #
      def resource_controller
        controller_name.to_sym
      end

      ##
      # Scope for permitted attributes. Defaults to singular or controller name
      #
      def resource_scope
        resource_controller.to_s.singularize.to_sym
      end

      ##
      # Namespace of the resource
      #
      # All of the controller path but the last segment
      #
      def resource_namespace
        path_without_controller = controller_path.split('/')[0..-2]

        path_without_controller.map(&:to_sym)
      end

      ##
      # Permitted attributes
      #
      def permitted_attributes
        %w[]
      end

      ##
      # Permitted new attributes
      #
      # Uses `permitted_attributes` unless overwritten here
      #
      def permitted_new_attributes
        permitted_attributes
      end

      ##
      # Permitted edit attributes
      #
      # Uses `permitted_attributes` unless overwritten here
      #
      def permitted_edit_attributes
        permitted_attributes
      end

      def resource_params
        permitted = permitted_attributes

        params.require(resource_scope).permit(permitted)
      end

      def resource_params_new
        permitted = permitted_new_attributes

        params.require(resource_scope).permit(permitted)
      end

      def resource_params_edit
        permitted = permitted_edit_attributes

        params.require(resource_scope).permit(permitted)
      end

      ##
      # Params when creating a resource
      #
      # On the `new` action it is `nil`. On the `create` action it uses
      # `resource_params_new` so validation errors can be displayed
      #
      def resource_new_params
        action_name.to_sym == :create ? resource_params_new : nil
      end

      ##
      # Location to redirect after creation
      #
      def location_after_create
        location_after_save
      end

      ##
      # Location to redirect after update
      #
      def location_after_update
        location_after_save
      end

      ##
      # Location to redirect after destroy
      #
      def location_after_destroy
        location_after_save
      end

      ##
      # Location to redirect after save
      #
      def location_after_save
        resources_path
      end

      private

      def resources_path(options = {})
        location_path = [resource_namespace, resource_controller].flatten
                                                                 .compact

        polymorphic_path(location_path, options)
      end
    end
  end
end
