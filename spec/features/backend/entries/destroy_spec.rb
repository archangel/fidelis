# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection Entries (HTML)', type: :feature do
  describe 'deletion' do
    let(:profile) { create(:user) }

    let(:collection) { create(:collection) }

    before do
      sign_in(profile)

      create(:field, collection: collection, slug: 'name')

      create(:entry, collection: collection, value: { name: 'Keep Me' })
      create(:entry, collection: collection, value: { name: 'Delete Me' })

      visit "/admin/collections/#{collection.id}/entries"

      within('tbody tr:eq(1)') { click_on 'Delete' }
    end

    it 'returns success message when the Collection is no longer available' do
      expect(page).to have_content('Entry was successfully destroyed.')
    end

    it 'does not have deleted resource' do
      within('tbody tr:eq(1)') do
        expect(page).not_to have_content('Delete Me')
      end
    end
  end
end
