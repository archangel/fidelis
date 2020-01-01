# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - User (HTML)', type: :feature do
  describe '#destroy' do
    before do
      sign_in(profile)

      create(:user, name: 'Delete Me')
      create(:user, name: 'Keep Me')
    end

    let(:profile) { create(:user) }

    it 'displays success message' do
      visit '/admin/users'

      within('tbody tr:eq(1)') { click_on 'Delete' }

      expect(page).to have_content('User was successfully destroyed.')
    end

    it 'does not list deleted User' do
      visit '/admin/users'

      within('tbody tr:eq(1)') { click_on 'Delete' }

      within('tbody tr:eq(1)') do
        expect(page).not_to have_content('Delete Me')
      end
    end
  end
end
