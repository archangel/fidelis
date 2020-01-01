# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Page (HTML)', type: :feature do
  describe '#destroy' do
    before do
      sign_in(profile)

      create(:page, title: 'Delete Me')
      create(:page, title: 'Keep Me')
    end

    let(:profile) { create(:user) }

    it 'displays success message' do
      visit '/admin/pages'

      within('tbody tr:eq(1)') { click_on 'Destroy' }

      expect(page).to have_content('Page was successfully destroyed.')
    end

    it 'does not list deleted Page' do
      visit '/admin/pages'

      within('tbody tr:eq(1)') { click_on 'Destroy' }

      within('tbody tr:eq(1)') do
        expect(page).not_to have_content('Delete Me')
      end
    end
  end
end
