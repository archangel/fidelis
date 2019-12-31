# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Meta tag', type: :feature do
  describe 'Site metatags' do
    let(:site) { create(:site, name: 'Caelum in terris') }

    before do
      create(:page, slug: 'amazing', title: 'Filius hominis')

      create(:metatag, metatagable: site,
                       name: 'description', content: 'O lux in Caelo')
      create(:metatag, metatagable: site,
                       name: 'author', content: 'Pater in Caelum')
    end

    it 'contains Site description meta tag' do
      visit '/amazing'

      expect(page).to have_meta(:description, 'O lux in Caelo')
    end

    it 'contains Site author meta tag' do
      visit '/amazing'

      expect(page).to have_meta(:author, 'Pater in Caelum')
    end

    it 'contains the correct Page title (e.g. Page Name | Site Name)' do
      visit '/amazing'

      expect(page).to have_title('Filius hominis | Caelum in terris')
    end
  end
end
