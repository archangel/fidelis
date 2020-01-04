# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom variable', type: :feature do
  before do
    create(:site, :with_logo, name: 'Amazing Grace', locale: 'en')

    create(:page, slug: 'amazing', content: resource_content)
  end

  let(:resource_content) do
    %(
      Site Name: {{ site.name }}
      Site Theme: {{ site.theme }}
      Site Locale: {{ site.locale }}
      Site Logo: {{ site.logo }}
      Site Unknown: >{{ site.unknown_variable }}<
    )
  end

  describe 'for `site` variable object' do
    before { visit '/amazing' }

    it 'knows the Site `name`' do
      expect(page).to have_content('Site Name: Amazing Grace')
    end

    it 'knows the Site `theme`' do
      expect(page).to have_content('Site Theme: default')
    end

    it 'knows the Site `locale`' do
      expect(page).to have_content('Site Locale: en')
    end

    it 'knows the Site `logo` with default' do
      expect(page).to have_content('Site Logo: logo.png')
    end

    it 'knows the Site `logo` with custom' do
      expect(page).to have_content('Site Logo: logo.png')
    end

    it 'returns blank for unknown Site properties' do
      expect(page).to have_content('Site Unknown: ><')
    end
  end
end
