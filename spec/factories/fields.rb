# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    collection

    sequence(:label) { |n| "Field #{n} Label" }
    sequence(:slug) { |n| "field-#{n}" }
    default_value { nil }
    classification { 'string' }
    required { false }

    trait :required do
      required { true }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
