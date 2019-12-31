# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meta tag', type: :feature do
  describe 'default metatags' do
    before { create(:site, name: 'Caelum in terris') }

    it 'contains canonical meta tag' do
      create(:page, slug: 'amazing')

      visit '/amazing'

      canonical = "link[rel='canonical'][href='#{page.current_host}/amazing']"

      expect(page).to have_css(canonical, visible: false)
    end

    it 'always uses Page.title for title (does not allow overwrite)' do
      resource = create(:page, slug: 'amazing', title: 'Filius hominis')

      create(:metatag, metatagable: resource,
                       name: 'title', content: 'Attempted Page Title')

      visit '/amazing'

      expect(page).to have_title('Filius hominis | Caelum in terris')
    end

    it 'does not use custom meta tag title (does not allow overwrite)' do
      resource = create(:page, slug: 'amazing', title: 'Filius hominis')

      create(:metatag, metatagable: resource,
                       name: 'title', content: 'Attempted Page Title')

      visit '/amazing'

      expect(page).not_to have_title('Attempted Page Title | Caelum in terris')
    end
  end
end
