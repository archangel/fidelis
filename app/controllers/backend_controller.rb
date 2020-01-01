# frozen_string_literal: true

class BackendController < ApplicationController
  include Controllers::AuthorizableConcern
  include Controllers::Html::MetatagableConcern
  include Helpers::Html::ActionableConcern

  before_action :authenticate_user!

  protected

  def default_meta_tags
    super.merge(noindex: true, nofollow: true, noarchive: true)
  end
end
