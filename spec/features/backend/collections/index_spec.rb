# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collections (HTML)', type: :feature do
  describe '#index' do
    before do
      sign_in(profile)

      ('A'..'Z').each do |letter|
        create(:collection, name: "Collection #{letter} Name")
      end
    end

    let(:profile) { create(:user) }

    describe 'sorted ascending from A-Z (`name` ASC)' do
      it 'lists the correct first resource' do
        visit '/admin/collections'

        within('tbody') do
          expect(page.find('tr:eq(1)')).to have_content('Collection A Name')
        end
      end

      it 'lists the correct second resource' do
        visit '/admin/collections'

        within('tbody') do
          expect(page.find('tr:eq(2)')).to have_content('Collection B Name')
        end
      end
    end

    describe 'paginated' do
      it 'finds the second page of Collections' do
        visit '/admin/collections?page=2'

        expect(page).to have_content('Collection Y Name')
      end

      it 'does not find the first page of Collections with `per` count' do
        visit '/admin/collections?page=2&per=3'

        expect(page).not_to have_content('Collection A Name')
      end

      it 'finds the second page of Collections with `per` count' do
        visit '/admin/collections?page=2&per=3'

        expect(page).to have_content('Collection D Name')
      end

      it 'finds nothing outside the count' do
        visit '/admin/collections?page=2&per=26'

        expect(page).to have_content('No collections found.')
      end
    end

    describe 'excludes' do
      it 'does not list deleted Collections' do
        create(:collection, :deleted, name: 'Deleted Collection Name')

        visit '/admin/collections'

        expect(page).not_to have_content('Deleted Collection Name')
      end
    end
  end
end
