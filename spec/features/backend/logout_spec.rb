# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging out', type: :feature do
  describe 'successfully logging out' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    it 'redirects to login page' do
      visit '/admin'

      click_link('Logout', href: '/admin/logout')

      expect(page).to have_current_path('/admin/login')
    end

    it 'sends flash message' do
      visit '/admin'

      click_link('Logout', href: '/admin/logout')

      expect(page).to have_content 'Signed out successfully.'
    end
  end
end
