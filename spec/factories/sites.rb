# frozen_string_literal: true

FactoryBot.define do
  factory :site do
    initialize_with { Site.first_or_create }

    sequence(:name) { |n| "Site #{n} Name" }
    theme { 'default' }
    locale { 'en' }

    # trait :logo do
    #   logo { fixture_file_upload(uploader_test_image) }
    # end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
