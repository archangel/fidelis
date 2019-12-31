# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meta tag', type: :feature do
  describe 'Page metatags' do
    let(:site) { create(:site, name: 'Caelum in terris') }
    let(:resource) { create(:page, slug: 'amazing', title: 'Filius hominis') }

    before do
      create(:metatag, metatagable: site,
                       name: 'description', content: 'O lux in Caelo')
      create(:metatag, metatagable: site,
                       name: 'author', content: 'Pater in Caelum')

      create(:metatag, metatagable: resource,
                       name: 'description', content: 'O lux in terris')
      create(:metatag, metatagable: resource,
                       name: 'keywords', content: 'amare,vita,fidem')
    end

    it 'contains Page description meta tag' do
      visit '/amazing'

      expect(page).to have_meta(:description, 'O lux in terris')
    end

    it 'does not use Site description when Page description meta tag used' do
      visit '/amazing'

      expect(page).not_to have_meta(:description, 'O lux in Caelo')
    end

    it 'contains Page keywords meta tag' do
      visit '/amazing'

      expect(page).to have_meta(:keywords, 'amare,vita,fidem')
    end

    it 'contains Site author meta tag' do
      visit '/amazing'

      expect(page).to have_meta(:author, 'Pater in Caelum')
    end

    it 'contains correct Page title (e.g. Page Name | Site Name)' do
      visit '/amazing'

      expect(page).to have_title('Filius hominis | Caelum in terris')
    end
  end
end
