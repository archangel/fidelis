# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Site (HTML)', type: :feature do
  def fill_in_site_form_with(fields = {})
    fill_in 'Name', with: fields.fetch(:name, '')
    fill_in 'Theme', with: fields.fetch(:theme, 'default')
    fill_in 'Locale', with: fields.fetch(:locale, 'en')
  end

  def fill_in_and_submit_site_form_with(fields = {})
    fill_in_site_form_with(fields)

    click_button 'Update Site'
  end

  describe '#edit' do
    before do
      # stub_authorization!

      create(:site, name: 'Amazing')
    end

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/site/edit'

        fill_in_and_submit_site_form_with(name: 'Grace')

        expect(page).to have_content('Site was successfully updated.')
      end
    end

    describe 'unsuccessful' do
      it 'fails without name' do
        visit '/admin/site/edit'

        fill_in_and_submit_site_form_with(name: '')

        expect(page.find('.string.site_name'))
          .to have_content("can't be blank")
      end

      it 'fails with invalid theme' do
        visit '/admin/site/edit'

        fill_in_and_submit_site_form_with(name: 'Grace', theme: 'fidelis')

        expect(page.find('.string.site_theme'))
          .to have_content('is not included in the list')
      end

      it 'fails with invalid locale' do
        visit '/admin/site/edit'

        fill_in_and_submit_site_form_with(name: 'Grace', locale: 'th')

        expect(page.find('.string.site_locale'))
          .to have_content('is not included in the list')
      end
    end
  end
end
