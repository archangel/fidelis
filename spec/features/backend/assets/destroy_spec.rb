# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Asset (HTML)', type: :feature do
  describe '#destroy' do
    before do
      sign_in(profile)

      create(:asset, name: 'delete_me.jpg')
      create(:asset, name: 'keep_me.jpg')
    end

    let(:profile) { create(:user) }

    it 'displays success message' do
      visit '/admin/assets'

      within('tbody tr:eq(1)') { click_on 'Delete' }

      expect(page).to have_content('Asset was successfully destroyed.')
    end

    it 'does not list deleted Asset' do
      visit '/admin/assets'

      within('tbody tr:eq(1)') { click_on 'Delete' }

      within('tbody tr:eq(1)') do
        expect(page).not_to have_content('delete_me.jpg')
      end
    end
  end
end
