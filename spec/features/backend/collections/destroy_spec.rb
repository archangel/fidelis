# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection (HTML)', type: :feature do
  describe '#destroy' do
    before do
      sign_in(profile)

      create(:collection, name: 'Delete Me')
      create(:collection, name: 'Keep Me')
    end

    let(:profile) { create(:user) }

    it 'displays success message' do
      visit '/admin/collections'

      within('tbody tr:eq(1)') { click_on 'Delete' }

      expect(page).to have_content('Collection was successfully destroyed.')
    end

    it 'does not list deleted Collection' do
      visit '/admin/collections'

      within('tbody tr:eq(1)') { click_on 'Delete' }

      within('tbody tr:eq(1)') do
        expect(page).not_to have_content('Delete Me')
      end
    end
  end
end
