# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Page (HTML)', type: :feature do
  describe '#show' do
    # before { stub_authorization! }

    describe 'is available' do
      let(:resource) { create(:page, title: 'Amazing Page', slug: 'amazing') }

      it 'finds the Page title' do
        visit "/admin/pages/#{resource.id}"

        expect(page).to have_content('Title: Amazing Page')
      end

      it 'finds the Page permalink' do
        visit "/admin/pages/#{resource.id}"

        expect(page).to have_content('Permalink: /amazing')
      end
    end

    describe 'is not available' do
      it 'returns 404 when it does not exist' do
        visit '/admin/pages/0'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns error message when it is deleted' do
        resource = create(:page, :deleted)

        visit "/admin/pages/#{resource.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
