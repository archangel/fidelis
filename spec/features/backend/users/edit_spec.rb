# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - User (HTML)', type: :feature do
  def fill_in_user_form_with(fields = {})
    fill_in 'Name', with: fields.fetch(:name, '')
  end

  def fill_in_and_submit_user_form_with(fields = {})
    fill_in_user_form_with(fields)

    click_button 'Update User'
  end

  describe '#edit' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'successful' do
      let(:resource) { create(:user) }

      it 'is displays success message with valid data' do
        visit "/admin/users/#{resource.id}/edit"

        fill_in_and_submit_user_form_with(name: 'Jesus')

        expect(page).to have_content('User was successfully updated.')
      end

      it 'does not allow editing username' do
        visit "/admin/users/#{resource.id}/edit"

        expect(page).to have_css('#user_username[disabled]')
      end

      it 'does not allow editing email address' do
        visit "/admin/users/#{resource.id}/edit"

        expect(page).to have_css('#user_email[disabled]')
      end
    end

    describe 'unsuccessful' do
      let(:resource) { create(:user) }

      it 'returns 404 when it does not exist' do
        visit '/admin/users/0/edit'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'fails without `name`' do
        visit "/admin/users/#{resource.id}/edit"

        fill_in_and_submit_user_form_with(name: '')

        expect(page.find('.string.user_name')).to have_content("can't be blank")
      end
    end
  end
end
