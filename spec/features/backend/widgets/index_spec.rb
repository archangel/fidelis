# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Widgets (HTML)', type: :feature do
  describe '#index' do
    before do
      # stub_authorization!

      ('A'..'Z').each do |letter|
        create(:widget, name: "Widget #{letter} Name")
      end
    end

    describe 'sorted ascending from A-Z (`name` ASC)' do
      it 'lists the correct first resource' do
        visit '/admin/widgets'

        within('tbody') do
          expect(page.find('tr:eq(1)')).to have_content('Widget A Name')
        end
      end

      it 'lists the correct second resource' do
        visit '/admin/widgets'

        within('tbody') do
          expect(page.find('tr:eq(2)')).to have_content('Widget B Name')
        end
      end
    end

    describe 'paginated' do
      it 'finds the second page of Widgets' do
        visit '/admin/widgets?page=2'

        expect(page).to have_content('Widget Y Name')
      end

      it 'does not find the first page of Widgets with `per` count' do
        visit '/admin/widgets?page=2&per=3'

        expect(page).not_to have_content('Widget A Name')
      end

      it 'finds the second page of Widgets with `per` count' do
        visit '/admin/widgets?page=2&per=3'

        expect(page).to have_content('Widget D Name')
      end

      it 'finds nothing outside the count' do
        visit '/admin/widgets?page=2&per=26'

        expect(page).to have_content('No widgets found.')
      end
    end

    describe 'excludes' do
      it 'does not list deleted Widgets' do
        create(:widget, :deleted, name: 'Deleted Widget Name')

        visit '/admin/widgets'

        expect(page).not_to have_content('Deleted Widget Name')
      end
    end
  end
end
