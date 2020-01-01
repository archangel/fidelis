# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
  def fill_in_login_form_with(fields = {})
    fill_in 'Email', with: fields.fetch(:email, '')
    fill_in 'Password', with: fields.fetch(:password, '')

    if fields.fetch(:homepage, false)
      check('Remember me')
    else
      uncheck('Remember me')
    end
  end

  def fill_in_and_submit_login_form_with(fields = {})
    fill_in_login_form_with(fields)

    click_button 'Log in'
  end

  describe 'accessing section when not logged in' do
    it 'redirects to login page' do
      visit '/admin/pages'

      expect(page).to have_current_path('/admin/login')
    end
  end

  describe 'with valid credentials' do
    before do
      create(:user, email: 'me@email.com', password: 'my secure password')
    end

    it 'is successful' do
      visit '/admin/login'

      fill_in_and_submit_login_form_with(email: 'me@email.com',
                                         password: 'my secure password')

      expect(page.body).to have_content 'Signed in successfully.'
    end

    it 'routes to Dashboard after successful login' do
      visit '/admin/login'

      fill_in_and_submit_login_form_with(email: 'me@email.com',
                                         password: 'my secure password')

      expect(page).to have_current_path('/admin')
    end

    it 'routes to original destination after successful login' do
      visit '/admin/pages'

      fill_in_and_submit_login_form_with(email: 'me@email.com',
                                         password: 'my secure password')

      expect(page).to have_current_path('/admin/pages')
    end
  end

  describe 'with invalid or unknown user credentials' do
    it 'is not successful' do
      visit '/admin/login'

      fill_in_and_submit_login_form_with(email: 'unknown@email.com',
                                         password: 'my secure password')

      expect(page.body).to have_content 'Invalid Email or password'
    end
  end

  describe 'with invited but not accepted User' do
    let(:message) do
      'You have a pending invitation, accept it to finish creating your account'
    end

    before { create(:user, :invited, email: 'me@email.com') }

    it 'fails with error message' do
      visit '/admin/login'

      fill_in_and_submit_login_form_with(email: 'me@email.com',
                                         password: 'my secure password')

      expect(page).to have_content(message)
    end
  end

  describe 'with multiple failed login attempts' do
    before { create(:user, email: 'me@email.com') }

    it 'locks account after 5 failed login attempts' do
      visit '/admin/login'

      5.times do
        fill_in_and_submit_login_form_with(email: 'me@email.com', password: '0')
      end

      expect(page).to have_content('Your account is locked.')
    end
  end

  describe 'with locked User' do
    before do
      create(:user, :locked, locked_at: 59.minutes.ago,
                             email: 'me@email.com',
                             password: 'my secure password')
    end

    it 'fails with error message before lock timeout expires' do
      visit '/admin/login'

      fill_in_and_submit_login_form_with(email: 'me@email.com',
                                         password: 'my secure password')

      expect(page).to have_content('Your account is locked.')
    end

    it 'is successful with recently unlocked user after lock timeout expired' do
      travel_to(2.minutes.from_now)

      visit '/admin/login'

      fill_in_and_submit_login_form_with(email: 'me@email.com',
                                         password: 'my secure password')

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
