# frozen_string_literal: true

class SitePolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    admin?
  end
end
