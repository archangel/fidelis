# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom tag', type: :feature do
  describe 'for `asset` tag' do
    before { asset }

    let(:asset) { create(:asset, name: 'amazing.png') }

    it 'returns content with valid Asset name' do
      create(:page, slug: 'amazing', content: "~{% asset 'amazing.png' %}~")

      visit '/amazing'

      expect(page).to have_css("img[src$='asset.png'][alt='amazing.png']")
    end

    it 'returns Asset with only `width` option (`height` not set)' do
      create(:page, slug: 'amazing',
                    content: "{% asset 'amazing.png' width: 100 %}")

      visit '/amazing'

      expect(page).to have_css("img[src$='asset.png'][alt='amazing.png']")
    end

    it 'returns Asset with only `height` option (`width` not set)' do
      create(:page, slug: 'amazing',
                    content: "{% asset 'amazing.png' height: 100 %}")

      visit '/amazing'

      expect(page).to have_css("img[src$='asset.png'][alt='amazing.png']")
    end

    it 'returns Asset with options' do
      create(:page, slug: 'amazing',
                    content: "{% asset 'amazing.png' alt: 'Amazing' %}")

      visit '/amazing'

      expect(page).to have_css("img[src$='asset.png'][alt='Amazing']")
    end

    it 'returns Asset with `title` option' do
      create(:page, slug: 'amazing',
                    content: "{% asset 'amazing.png' title: 'Amazing' %}")

      visit '/amazing'

      expect(page).to have_css("img[src$='asset.png'][title='Amazing']")
    end

    it 'returns nothing with deleted Asset' do
      create(:asset, :deleted, name: 'deleted.jpg')
      create(:page, slug: 'amazing', content: "~{% asset 'deleted.jpg' %}~")

      visit '/amazing'

      expect(page).to have_content('~~')
    end

    it 'returns nothing when Asset is not found' do
      create(:page, slug: 'amazing', content: "~{% asset 'unknown.jpg' %}~")

      visit '/amazing'

      expect(page).to have_content('~~')
    end
  end
end
