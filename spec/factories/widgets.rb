# frozen_string_literal: true

FactoryBot.define do
  factory :widget do
    design { nil }
    sequence(:name) { |n| "Widget #{n} Name" }
    sequence(:slug) { |n| "widget-#{n}" }
    content { '<p>Content of the widget</p>' }

    trait :with_design do
      association :design, factory: :design, partial: true
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
