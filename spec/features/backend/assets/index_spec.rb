# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Assets (HTML)', type: :feature do
  describe '#index' do
    before do
      sign_in(profile)

      ('a'..'z').each { |letter| create(:asset, name: "asset-#{letter}.jpg") }
    end

    let(:profile) { create(:user) }

    describe 'sorted ascending from A-Z (`name` ASC)' do
      it 'lists the correct first resource' do
        visit '/admin/assets'

        within('tbody') do
          expect(page.find('tr:eq(1)')).to have_content('asset-a.jpg')
        end
      end

      it 'lists the correct second resource' do
        visit '/admin/assets'

        within('tbody') do
          expect(page.find('tr:eq(2)')).to have_content('asset-b.jpg')
        end
      end
    end

    describe 'paginated' do
      it 'finds the second page of Assets' do
        visit '/admin/assets?page=2'

        expect(page).to have_content('asset-y.jpg')
      end

      it 'does not find the first page of Assets with `per` count' do
        visit '/admin/assets?page=2&per=3'

        expect(page).not_to have_content('asset-a.jpg')
      end

      it 'finds the second page of Assets with `per` count' do
        visit '/admin/assets?page=2&per=3'

        expect(page).to have_content('asset-d.jpg')
      end

      it 'finds nothing outside the count' do
        visit '/admin/assets?page=2&per=26'

        expect(page).to have_content('No assets found.')
      end
    end

    describe 'excludes' do
      it 'does not list deleted Assets' do
        create(:asset, :deleted, name: 'deleted-asset.jpg')

        visit '/admin/assets'

        expect(page).not_to have_content('deleted-asset.jpg')
      end
    end
  end
end
