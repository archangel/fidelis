# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom variable', type: :feature do
  before { resource }

  let(:resource) do
    create(:page, title: 'Amazing Grace', slug: 'amazing',
                  published_at: '2019-04-22 03:09:40 UTC',
                  content: resource_content)
  end

  let(:resource_content) do
    %(
      Page ID: {{ page.id }}
      Page Homepage: {{ page.homepage }}
      Page Title: {{ page.title }}
      Page Permalink: {{ page.permalink }}
      Page Published At: {{ page.published_at }}
      Page Timestamp: {{ page.timestamp }}
      Page Unknown: >{{ page.unknown_variable }}<
    )
  end

  describe 'for `page` variable object' do
    before { visit '/amazing' }

    it 'knows the Page `id`' do
      expect(page).to have_content("Page ID: #{resource.id}")
    end

    it 'knows the Page `homepage` status' do
      expect(page).to have_content('Page Homepage: false')
    end

    it 'knows the Page `title`' do
      expect(page).to have_content('Page Title: Amazing Grace')
    end

    it 'knows the Page `permalink`' do
      expect(page).to have_content('Page Permalink: /amazing')
    end

    it 'knows the Page `publishd_at`' do
      expect(page).to have_content('Page Published At: 2019-04-22 03:09:40 UTC')
    end

    it 'knows the Page `timestamp`' do
      expect(page).to have_content('Page Timestamp: 1555902580')
    end

    it 'returns blank for unknown Page properties' do
      expect(page).to have_content('Page Unknown: ><')
    end
  end
end
