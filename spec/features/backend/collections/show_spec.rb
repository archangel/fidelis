# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection (HTML)', type: :feature do
  describe '#show' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'is available' do
      let(:resource) { create(:collection, name: 'Amazing Collection') }

      it 'finds the Collection name' do
        visit "/admin/collections/#{resource.id}"

        expect(page).to have_content('Name: Amazing Collection')
      end
    end

    describe 'is not available' do
      it 'returns 404 when it does not exist' do
        visit '/admin/collections/0'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns error message when it is deleted' do
        resource = create(:collection, :deleted)

        visit "/admin/collections/#{resource.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
