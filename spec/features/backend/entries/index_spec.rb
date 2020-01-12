# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection Entries (HTML)', type: :feature do
  describe 'listing' do
    let(:profile) { create(:user) }

    let(:collection) { create(:collection) }

    before do
      sign_in(profile)

      create(:field, collection: collection, label: 'Name', slug: 'name')

      ('A'..'Z').each do |letter|
        create(:entry, collection: collection,
                       value: {
                         name: "Entry #{letter} Name"
                       })
      end
    end

    describe 'sorted descending (Z-A) from position' do
      before { visit "/admin/collections/#{collection.id}/entries" }

      it 'finds the first (Z) resource' do
        expect(page.find('tbody tr:eq(1)')).to have_content('Entry Z Name')
      end

      it 'finds the second (Y) resource' do
        expect(page.find('tbody tr:eq(2)')).to have_content('Entry Y Name')
      end

      it 'finds the third (X) resource' do
        expect(page.find('tbody tr:eq(3)')).to have_content('Entry X Name')
      end
    end

    describe 'paginated' do
      it 'does not find the first page of Entries' do
        visit "/admin/collections/#{collection.id}/entries?page=2"

        within('tbody') do
          expect(page).not_to have_content('Entry Z Name')
        end
      end

      it 'finds the second page of Entries' do
        visit "/admin/collections/#{collection.id}/entries?page=2"

        within('tbody') do
          expect(page).to have_content('Entry B Name')
        end
      end

      it 'does not find the first page of Entries with `per` count' do
        visit "/admin/collections/#{collection.id}/entries?page=2&per=3"

        within('tbody') do
          expect(page).not_to have_content('Entry Z Name')
        end
      end

      it 'finds the second page of Entries with `per` count' do
        visit "/admin/collections/#{collection.id}/entries?page=2&per=3"

        within('tbody') do
          expect(page).to have_content('Entry W Name')
        end
      end

      it 'finds nothing outside the count' do
        visit "/admin/collections/#{collection.id}/entries?page=2&per=26"

        expect(page).to have_content('No entries found.')
      end
    end

    describe 'excludes' do
      it 'does not return deleted Entries' do
        create(:entry, :deleted, collection: collection)

        visit "/admin/collections/#{collection.id}/entries"

        within('tbody') do
          expect(page).not_to have_content('Deleted Entry Name')
        end
      end
    end
  end
end
