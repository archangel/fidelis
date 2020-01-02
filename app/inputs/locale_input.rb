# frozen_string_literal: true

class LocaleInput < SimpleForm::Inputs::CollectionSelectInput
  def skip_include_blank?
    true
  end

  protected

  def collection
    @collection ||= resource_options
  end

  def resource_options
    [].tap do |option|
      I18n.available_locales.map(&:to_s).each do |language|
        option << [
          I18n.t("languages.#{language}.name", default: 'ltr'), language
        ]
      end
    end
  end
end
