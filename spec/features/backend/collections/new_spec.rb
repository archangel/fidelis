# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection (HTML)', type: :feature do
  def fill_in_collection_form_with(fields = {})
    fill_in 'Name', with: fields.fetch(:name, '')
    find(:css, '//input[@name="collection[slug]"]').set fields.fetch(:slug, '')
  end

  # rubocop:disable Metrics/MethodLength
  def fill_in_field_form_with(index = 1, fields = {})
    path = ".form-group.collection_fields .nested-fields:nth-of-type(#{index})"
    within path do
      classification = fields.fetch(:classification, '')

      if classification.present?
        select classification, from: 'Classification', match: :first
      end
      fill_in 'Label', with: fields.fetch(:label, '')
      fill_in 'Slug', with: fields.fetch(:slug, '')
      fill_in 'Default Value', with: fields.fetch(:default, '')
      fields.fetch(:required, false) ? check('Required') : uncheck('Required')
    end
  end
  # rubocop:enable Metrics/MethodLength

  describe '#new' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'successful' do
      before { visit '/admin/collections/new' }

      it 'is displays success message with valid data' do
        fill_in_collection_form_with(name: 'Great Collection', slug: 'amazing')
        fill_in_field_form_with(1, classification: 'String', label: 'name',
                                   slug: 'name')
        click_button 'Create Collection'

        expect(page).to have_content('Collection was successfully created.')
      end

      it 'successful without slug (uses slugged Name)' do
        fill_in_collection_form_with(name: 'Amazing Collection')
        fill_in_field_form_with(1, classification: 'String', label: 'name',
                                   slug: 'name')
        click_button 'Create Collection'

        expect(page).to have_content('Collection was successfully created.')
      end
    end

    describe 'unsuccessful' do
      before { visit '/admin/collections/new' }

      it 'fails without `name`' do
        fill_in_collection_form_with(name: '')
        fill_in_field_form_with(1, classification: 'String', label: 'name')
        click_button 'Create Collection'

        expect(page.find('.string.collection_name'))
          .to have_content("can't be blank")
      end

      it 'fails without Field `label`' do
        fill_in_collection_form_with(name: 'Great Collection', slug: 'amazing')
        fill_in_field_form_with(1, classification: 'String', slug: 'name')
        click_button 'Create Collection'

        expect(page.find('.string.collection_fields_label'))
          .to have_content("can't be blank")
      end

      it 'fails without Field `slug`' do
        fill_in_collection_form_with(name: 'Great Collection', slug: 'amazing')
        fill_in_field_form_with(1, classification: 'String', label: 'name')
        click_button 'Create Collection'

        expect(page.find('.string.collection_fields_slug'))
          .to have_content("can't be blank")
      end
    end
  end
end
