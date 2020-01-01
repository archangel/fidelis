# frozen_string_literal: true

FactoryBot.define do
  factory :site do
    initialize_with { Site.first_or_create }

    sequence(:name) { |n| "Site #{n} Name" }
    theme { 'default' }
    locale { 'en' }

    trait :with_logo do
      logo do
        Rack::Test::UploadedFile.new(
          ::Rails.root.join('spec/fixtures/files/image.gif')
        )
      end
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
