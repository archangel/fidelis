# frozen_string_literal: true

FactoryBot.define do
  factory :metatag do
    association(:metatagable, factory: :page)
    name { 'author' }
    content { 'Archangel CMS' }

    trait :for_page do
      association(:metatagable, factory: :page)
      name { 'description' }
      content { 'This is the description of this Page' }
    end

    trait :for_site do
      association(:metatagable, factory: :site)
      name { 'description' }
      content { 'This is the description of this Site' }
    end
  end
end
