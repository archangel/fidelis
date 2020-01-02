# frozen_string_literal: true

class RoleInput < SimpleForm::Inputs::CollectionSelectInput
  def skip_include_blank?
    true
  end

  protected

  def collection
    @collection ||= resource_options
  end

  def resource_options
    [].tap do |option|
      ROLES.each do |kind|
        option << [I18n.t("roles.#{kind}", default: kind.titleize), kind]
      end
    end
  end
end
