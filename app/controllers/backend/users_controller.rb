# frozen_string_literal: true

module Backend
  class UsersController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    protected

    def permitted_attributes
      %w[email name username]
    end

    def resources_content
      @users = User.where.not(id: current_user.id)
                   .order(name: :asc)
                   .page(page_num).per(per_page)

      authorize @users
    end

    def resource_content
      resource_id = params.fetch(:id)

      @user = User.where.not(id: current_user.id).find_by!(id: resource_id)

      authorize @user
    end

    def resource_new_content
      resource = User.new

      if action_name.to_sym == :create
        resource = User.invite!(resource_new_params, current_user)
      end

      @user = resource

      authorize @user
    end
  end
end
