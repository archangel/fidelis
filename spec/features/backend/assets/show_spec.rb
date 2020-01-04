# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Asset (HTML)', type: :feature do
  describe '#show' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'is available' do
      let(:resource) do
        create(:asset, name: 'amazing-asset.jpg')
      end

      it 'finds the Asset name' do
        visit "/admin/assets/#{resource.id}"

        expect(page).to have_content('Name: amazing-asset.jpg')
      end
    end

    describe 'is not available' do
      it 'returns 404 when it does not exist' do
        visit '/admin/assets/0'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns error message when it is deleted' do
        resource = create(:asset, :deleted)

        visit "/admin/assets/#{resource.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
