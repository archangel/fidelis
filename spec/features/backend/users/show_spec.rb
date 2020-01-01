# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - User (HTML)', type: :feature do
  describe '#show' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'is available' do
      let(:resource) { create(:user, name: 'Domino in caelum') }

      it 'finds the User name' do
        visit "/admin/users/#{resource.id}"

        expect(page).to have_content('Name: Domino in caelum')
      end
    end

    describe 'is not available' do
      it 'returns 404 when it does not exist' do
        visit '/admin/users/0'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 for current User' do
        visit "/admin/users/#{profile.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns error message when it is deleted' do
        resource = create(:user, :deleted)

        visit "/admin/users/#{resource.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
