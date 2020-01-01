# frozen_string_literal: true

module Helpers
  module Html
    ##
    # Action helpers
    #
    # Example
    #   if action?(:something)
    #     ...
    #   end
    #
    #   if collection_action?
    #     ...
    #   end
    #
    #   if create_action?
    #     ...
    #   end
    #
    #   # Mind the plural. Includes both :new and :create
    #   if create_actions?
    #     ...
    #   end
    #
    #   if index_action?
    #     ...
    #   end
    #
    #   if member_action?
    #     ...
    #   end
    #
    #   if new_action?
    #     ...
    #   end
    #
    #   if show_action?
    #     ...
    #   end
    #
    #   if update_action?
    #     ...
    #   end
    #
    #   # Mind the plural. Includes both :edit and :update
    #   if update_actions?
    #     ...
    #   end
    #
    module ActionableConcern
      extend ActiveSupport::Concern

      included do
        helper_method :action?,
                      :collection_action?,
                      :create_action?,
                      :create_actions?,
                      :edit_action?,
                      :index_action?,
                      :member_action?,
                      :new_action?,
                      :show_action?,
                      :update_action?,
                      :update_actions?
      end

      def action?(action_method)
        action == action_method.to_sym
      end

      %w[create edit index new show update].each do |rest_action|
        define_method("#{rest_action}_action?".to_sym) do
          action?(rest_action)
        end
      end

      def collection_action?
        collection_actions.include?(action)
      end

      def create_actions?
        %i[create new].include?(action)
      end
      alias new_actions? create_actions?

      def member_action?
        member_actions.include?(action)
      end

      def update_actions?
        %i[edit update].include?(action)
      end
      alias edit_actions? update_actions?

      protected

      def collection_actions
        %i[index]
      end

      def member_actions
        %i[edit show update]
      end

      private

      def action
        action_name.to_sym
      end
    end
  end
end
