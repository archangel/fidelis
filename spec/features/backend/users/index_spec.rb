# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Users (HTML)', type: :feature do
  describe '#index' do
    before do
      sign_in(profile)

      ('A'..'Z').each { |letter| create(:user, name: "User #{letter} Name") }
    end

    let(:profile) { create(:user, name: 'Current User') }

    describe 'sorted ascending from A-Z (`name` ASC)' do
      it 'lists the correct first resource' do
        visit '/admin/users'

        within('tbody') do
          expect(page.find('tr:eq(1)')).to have_content('User A Name')
        end
      end

      it 'lists the correct second resource' do
        visit '/admin/users'

        within('tbody') do
          expect(page.find('tr:eq(2)')).to have_content('User B Name')
        end
      end
    end

    describe 'paginated' do
      it 'finds the second page of Users' do
        visit '/admin/users?page=2'

        expect(page).to have_content('User Y Name')
      end

      it 'does not find the first page of Users with `per` count' do
        visit '/admin/users?page=2&per=3'

        expect(page).not_to have_content('User A Name')
      end

      it 'finds the second page of Users with `per` count' do
        visit '/admin/users?page=2&per=3'

        expect(page).to have_content('User D Name')
      end

      it 'finds nothing outside the count' do
        visit '/admin/users?page=2&per=26'

        expect(page).to have_content('No users found.')
      end
    end

    describe 'excludes' do
      it 'does not list deleted Users' do
        create(:user, :deleted, name: 'Deleted User Name')

        visit '/admin/users'

        expect(page).not_to have_content('Deleted User Name')
      end

      it 'does not current employee' do
        visit '/admin/users'

        expect(page).not_to have_content('Current User')
      end
    end
  end
end
