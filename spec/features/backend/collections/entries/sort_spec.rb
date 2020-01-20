# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection Entries (HTML)', type: :feature do
  describe 'sort', js: true do
    let(:profile) { create(:user) }

    let(:collection) { create(:collection) }

    before do
      sign_in(profile)

      create(:field, collection: collection, label: 'Name', slug: 'name')

      ('A'..'D').each do |letter|
        create(:entry, collection: collection,
                       value: { name: "Entry #{letter} Name" })
      end

      visit "/admin/collections/#{collection.id}/entries"
    end

    it 'can drag/drop entry to sort' do
      draggable = page.find('.table-sortable tbody tr:nth-child(4)
                             .sortable-handle')
      droppable = page.find('.table-sortable tbody tr:nth-child(1)')

      draggable.drag_to(droppable)

      wait_for_ajax

      expect(page).to have_content('Sort order has been updated')
    end
  end
end
