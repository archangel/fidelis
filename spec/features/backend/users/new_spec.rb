# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - User (HTML)', type: :feature do
  def fill_in_user_form_with(fields = {})
    fill_in 'Name', with: fields.fetch(:name, '')
    fill_in 'Username', with: fields.fetch(:username, '')
    fill_in 'Email', with: fields.fetch(:email, '')
  end

  def fill_in_and_submit_user_form_with(fields = {})
    fill_in_user_form_with(fields)

    click_button 'Create User'
  end

  describe '#new' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/users/new'

        fill_in_and_submit_user_form_with(name: 'Jesus', username: 'jesus',
                                          email: 'jesus@heaven.com')

        expect(page).to have_content('User was successfully created.')
      end
    end

    describe 'unsuccessful' do
      before { create(:user, username: 'michael', email: 'michael@heaven.com') }

      it 'fails without `name`' do
        visit '/admin/users/new'

        fill_in_and_submit_user_form_with(name: '', username: 'jesus',
                                          email: 'jesus@heaven.com')

        expect(page.find('.string.user_name')).to have_content("can't be blank")
      end

      it 'fails without `email`' do
        visit '/admin/users/new'

        fill_in_and_submit_user_form_with(name: 'Jesus', username: 'jesus',
                                          email: '')

        expect(page.find('.email.user_email'))
          .to have_content("can't be blank")
      end

      it 'fails without `username`' do
        visit '/admin/users/new'

        fill_in_and_submit_user_form_with(name: 'Jesus', username: '',
                                          email: 'jesus@heaven.com')

        expect(page.find('.string.user_username'))
          .to have_content("can't be blank")
      end

      it 'fails with used `username`' do
        visit '/admin/users/new'

        fill_in_and_submit_user_form_with(name: 'Jesus', username: 'michael',
                                          email: 'jesus@heaven.com')

        expect(page.find('.string.user_username'))
          .to have_content('has already been taken')
      end
    end
  end
end
