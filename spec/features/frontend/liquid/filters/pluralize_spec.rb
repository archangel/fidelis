# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom filter', type: :feature do
  describe '`pluralize` Liquid filter' do
    it 'pluralizes with simple text' do
      create(:page, slug: 'amazing', content: '>{{ "angel" | pluralize }}<')

      visit '/amazing'

      expect(page).to have_content('>angels<')
    end

    it 'pluralizes with complex text' do
      create(:page, slug: 'amazing', content: '>{{ "octopus" | pluralize }}<')

      visit '/amazing'

      expect(page).to have_content('>octopi<')
    end

    it 'does not pluralize when already pluralized' do
      create(:page, slug: 'amazing', content: '>{{ "angels" | pluralize }}<')

      visit '/amazing'

      expect(page).to have_content('>angels<')
    end
  end
end
