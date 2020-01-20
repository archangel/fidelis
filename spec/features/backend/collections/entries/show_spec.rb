# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection Entry (HTML)', type: :feature do
  describe 'show' do
    let(:profile) { create(:user) }

    let(:collection) { create(:collection) }

    before { sign_in(profile) }

    describe 'is available' do
      let(:resource) do
        create(:entry, collection: collection,
                       value: {
                         name: 'Entry Name',
                         slug: 'entry-slug'
                       })
      end

      before do
        create(:field, collection: collection,
                       label: 'Field Name', slug: 'name')
        create(:field, collection: collection,
                       label: 'Field Slug', slug: 'slug')

        visit "/admin/collections/#{collection.id}/entries/#{resource.id}"
      end

      it 'finds the Entry name' do
        expect(page).to have_content('Field Name: Entry Name')
      end

      it 'finds the Entry slug' do
        expect(page).to have_content('Field Slug: entry-slug')
      end
    end

    describe 'is not available' do
      it 'returns 404 status when it does not exist' do
        visit "/admin/collections/#{collection.id}/entries/0"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'return error message when deleted' do
        resource = create(:entry, :deleted,
                          collection: collection,
                          value: { name: 'Entry Name', slug: 'entry-slug' })

        visit "/admin/collections/#{collection.id}/entries/#{resource.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
