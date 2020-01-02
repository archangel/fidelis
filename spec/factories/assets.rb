# frozen_string_literal: true

FactoryBot.define do
  factory :asset do
    sequence(:name) { |n| "file-#{n}-name.jpg" }
    file do
      Rack::Test::UploadedFile.new(
        ::Rails.root.join('spec/fixtures/files/asset.png')
      )
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
