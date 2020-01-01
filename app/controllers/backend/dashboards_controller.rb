# frozen_string_literal: true

module Backend
  class DashboardsController < BackendController
    include Controllers::SkipAuthorizableConcern

    def show; end
  end
end
