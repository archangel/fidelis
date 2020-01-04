# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom filter', type: :feature do
  describe '`titleize` Liquid filter' do
    it 'titleizes with simple text' do
      create(:page, slug: 'amazing',
                    content: '>{{ "the holy bible" | titleize }}<')

      visit '/amazing'

      expect(page).to have_content('>The Holy Bible<')
    end

    it 'titleizes with more complex text' do
      create(:page,
             slug: 'amazing',
             content: '>{{ "the holy bible: the new testament" | titleize }}<')

      visit '/amazing'

      expect(page).to have_content('>The Holy Bible: The New Testament<')
    end

    it 'titleizes with underscores' do
      create(:page,
             slug: 'amazing', content: '>{{ "the_holy_bible" | titleize }}<')

      visit '/amazing'

      expect(page).to have_content('>The Holy Bible<')
    end

    it 'titleizes with dashes' do
      create(:page,
             slug: 'amazing', content: '>{{ "the-holy-bible" | titleize }}<')

      visit '/amazing'

      expect(page).to have_content('>The Holy Bible<')
    end
  end
end
