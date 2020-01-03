# frozen_string_literal: true

class AssetPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def wysiwyg?
    true
  end
end
