# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Site (HTML)', type: :feature do
  def fill_in_site_form_with(fields = {})
    locale = fields.fetch(:locale, 'en')

    fill_in 'Name', with: fields.fetch(:name, '')
    fill_in 'Theme', with: fields.fetch(:theme, 'default')
    select locale, from: 'Locale', match: :first if locale.present?
  end

  def fill_in_and_submit_site_form_with(fields = {})
    fill_in_site_form_with(fields)

    click_button 'Update Site'
  end

  describe '#edit' do
    before do
      sign_in(profile)

      create(:site, :with_logo, name: 'Amazing')
    end

    let(:profile) { create(:user) }

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/site/edit'

        fill_in_and_submit_site_form_with(name: 'Grace')

        expect(page).to have_content('Site was successfully updated.')
      end

      it 'returns success message with logo' do
        visit '/admin/site/edit'

        attach_file 'Logo', file_fixture('files/logo.png')
        click_button 'Update Site'

        expect(page).to have_content('Site was successfully updated.')
      end

      it 'returns success message when removing a logo' do
        visit '/admin/site/edit'

        check('Remove Logo')
        click_button 'Update Site'

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
    end
  end
end
