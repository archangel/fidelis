# frozen_string_literal: true

class FieldClassificationInput < SimpleForm::Inputs::CollectionSelectInput
  def skip_include_blank?
    true
  end

  protected

  def collection
    @collection ||= resource_options
  end

  def resource_options
    [].tap do |option|
      Field::CLASSIFICATIONS.each do |kind|
        option << [I18n.t("classification.#{kind}", default: kind.titleize), kind]
      end
    end
  end
end
# , collection: Field::CLASSIFICATIONS, prompt: :translate
