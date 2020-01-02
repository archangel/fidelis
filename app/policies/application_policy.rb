# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :record, :user

  def initialize(user, record)
    @user = user
    @record = record
  end

  %w[index show create update destroy].each do |rest_action|
    define_method("#{rest_action}?".to_sym) do
      false
    end
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  protected

  ROLES.each do |role|
    define_method("#{role}?".to_sym) do
      user.role == role
    end
  end
end
