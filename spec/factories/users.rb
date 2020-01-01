# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Employee #{n}" }
    sequence(:username) { |n| "employee-#{n}" }
    sequence(:email) { |n| "employee-#{n}@example.com" }
    password { 'password1234' }
    invitation_created_at { Time.current }
    invitation_accepted_at { Time.current }
    confirmed_at { Time.current }
    role { 'admin' }

    trait :with_avatar do
      avatar do
        Rack::Test::UploadedFile.new(
          ::Rails.root.join('spec/fixtures/files/avatar.png')
        )
      end
    end

    trait :with_admin_role do
      role { 'admin' }
    end

    trait :with_editor_role do
      role { 'editor' }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :invited do
      sequence(:invitation_token) { |n| "invitation_token-#{n}" }
      invitation_accepted_at { nil }
    end

    trait :reset do
      reset_password_token { 'abcdef123456' }
      reset_password_sent_at { Time.current }
    end

    trait :locked do
      failed_attempts { 10 }
      unlock_token { '123456abcdef' }
      locked_at { Time.current }
    end

    trait :tracked do
      sign_in_count { 2 }
      current_sign_in_at { Time.current }
      last_sign_in_at { 1.day.ago }
      current_sign_in_ip { '127.0.0.1' }
      last_sign_in_ip { '127.0.0.1' }
    end

    trait :deleted do
      deleted_at { Time.current }
    end
  end
end
