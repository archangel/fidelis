# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom filter', type: :feature do
  describe '`singularize` Liquid filter' do
    it 'singularizes with simple text' do
      create(:page, slug: 'amazing', content: '>{{ "angels" | singularize }}<')

      visit '/amazing'

      expect(page).to have_content('>angel<')
    end

    it 'singularizes with complex text' do
      create(:page, slug: 'amazing', content: '>{{ "octopi" | singularize }}<')

      visit '/amazing'

      expect(page).to have_content('>octopus<')
    end

    it 'does not singularize when already singularized' do
      create(:page, slug: 'amazing', content: '>{{ "angel" | singularize }}<')

      visit '/amazing'

      expect(page).to have_content('>angel<')
    end
  end
end
