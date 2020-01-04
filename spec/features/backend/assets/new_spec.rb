# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Asset (HTML)', type: :feature do
  def fill_in_asset_form_with(fields = {})
    file = fields.fetch(:file, nil)

    fill_in 'Name', with: fields.fetch(:name, '')
    attach_file 'File', file_fixture(file) if file.present?
  end

  def fill_in_and_submit_asset_form_with(fields = {})
    fill_in_asset_form_with(fields)

    click_button 'Create Asset'
  end

  describe '#new' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/assets/new'

        fill_in_and_submit_asset_form_with(name: 'archangel.png',
                                           file: 'files/logo.png')

        expect(page).to have_content('Asset was successfully created.')
      end
    end

    describe 'unsuccessful' do
      it 'fails without `name`' do
        visit '/admin/assets/new'

        fill_in_and_submit_asset_form_with(name: '',
                                           file: 'files/logo.png')

        expect(page.find('.string.asset_name'))
          .to have_content("can't be blank")
      end

      it 'fails when `name` is not a filename' do
        visit '/admin/assets/new'

        fill_in_and_submit_asset_form_with(name: 'my file',
                                           file: 'files/logo.png')

        expect(page.find('.string.asset_name'))
          .to have_content('is not a valid file name')
      end

      it 'fails without `file`' do
        visit '/admin/assets/new'

        fill_in_and_submit_asset_form_with(name: 'archangel.jpg')

        expect(page.find('.file.asset_file')).to have_content("can't be blank")
      end

      it 'fails when `file` is not an image' do
        visit '/admin/assets/new'

        fill_in_and_submit_asset_form_with(name: 'archangel.jpg',
                                           file: 'files/stylesheet.css')

        expect(page.find('.file.asset_file'))
          .to have_content('has an invalid content type')
      end
    end
  end
end
