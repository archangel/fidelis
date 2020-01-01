# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Profile (HTML)', type: :feature do
  def fill_in_profile_form_with(fields = {})
    avatar = fields.fetch(:avatar, '')

    fill_in 'Name', with: fields.fetch(:name, '')
    fill_in 'Username', with: fields.fetch(:username, '')
    attach_file 'Avatar', avatar if avatar.present?
    fill_in 'Password', with: fields.fetch(:password, ''), match: :prefer_exact
    fill_in 'Password Confirmation', with: fields.fetch(:confirm_password, ''),
                                     match: :prefer_exact
  end

  def fill_in_and_submit_profile_form_with(fields = {})
    fill_in_profile_form_with(fields)

    click_button 'Update Profile'
  end

  describe '#edit' do
    before { sign_in(profile) }

    let(:profile) { create(:user, :with_avatar) }

    describe 'successful' do
      it 'does not allow editing email address' do
        visit '/admin/profile/edit'

        expect(page).to have_css('#profile_email[disabled]')
      end

      it 'returns success message with avatar' do
        visit '/admin/profile/edit'

        attach_file 'Avatar', file_fixture('files/avatar.png')
        click_button 'Update Profile'

        expect(page).to have_content('Profile was successfully updated.')
      end

      it 'returns success message when removing a avatar' do
        visit '/admin/profile/edit'

        check('Remove Avatar')
        click_button 'Update Profile'

        expect(page).to have_content('Profile was successfully updated.')
      end

      it 'succeeds without Password change' do
        visit '/admin/profile/edit'

        fill_in_and_submit_profile_form_with(name: 'God Almighty',
                                             username: 'unus')

        expect(page).to have_content('Profile was successfully updated.')
      end

      it 'succeeds with password change' do
        visit '/admin/profile/edit'

        fill_in_and_submit_profile_form_with(name: 'God', username: 'god',
                                             password: 'new-password',
                                             confirm_password: 'new-password')

        expect(page).to have_content('Profile was successfully updated.')
      end

      it 'succeeds with password confirmation but without password' do
        visit '/admin/profile/edit'

        fill_in_and_submit_profile_form_with(name: 'God', username: 'god',
                                             password: '',
                                             confirm_password: 'new-password')

        expect(page).to have_content('Profile was successfully updated.')
      end
    end

    describe 'unsuccessful' do
      it 'fails without name' do
        visit '/admin/profile/edit'

        fill_in_and_submit_profile_form_with(name: '')

        expect(page.find('.string.profile_name'))
          .to have_content("can't be blank")
      end

      it 'fails with password and password confirmation mismatch' do
        visit '/admin/profile/edit'

        fill_in_and_submit_profile_form_with(name: 'God', username: 'god',
                                             password: 'heaven',
                                             confirm_password: 'hell')

        expect(page.find('.password.profile_password_confirmation'))
          .to have_content("doesn't match Password")
      end
    end
  end
end
