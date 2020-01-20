# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Collection Entries (HTML)', type: :feature do
  # def fill_in_entry_form_with(fields = {})
  #   parent = fields.fetch(:parent, '')
  #
  #   fill_in 'Name', with: fields.fetch(:name, '')
  #   select parent, from: 'Parent', match: :first if parent.present?
  #   fill_in 'Content', with: fields.fetch(:content, '')
  #   fields.fetch(:partial, false) ? check('Partial') : uncheck('Partial')
  #
  #   fill_in 'Published At', with: fields.fetch(:published_at, Time.current)
  # end
  #
  # def fill_in_and_submit_entry_form_with(fields = {})
  #   fill_in_entry_form_with(fields)
  #
  #   click_button 'Create Entry'
  # end

  describe 'creation' do
    let(:profile) { create(:user) }

    let(:collection) { create(:collection) }

    before { sign_in(profile) }

    describe 'successful' do
      before do
        create(:field, collection: collection, label: 'Name', slug: 'name')
        create(:field, collection: collection, label: 'Slug', slug: 'slug',
                       required: true)

        visit "/admin/collections/#{collection.id}/entries/new"
      end

      it 'returns success message with valid data' do
        fill_in 'Name', with: 'Archangel Gabriel'
        fill_in 'Slug', with: 'gabriel'
        fill_in 'Published At', with: '2019-11-24 03:41:18 UTC'
        click_button 'Create Entry'

        expect(page).to have_content('Entry was successfully created.')
      end

      it 'returns success message when non-required field is empty' do
        fill_in 'Name', with: ''
        fill_in 'Slug', with: 'gabriel'
        fill_in 'Published At', with: ''
        click_button 'Create Entry'

        expect(page).to have_content('Entry was successfully created.')
      end
    end

    describe 'unsuccessful' do
      before do
        create(:field, collection: collection, required: true,
                       label: 'Required Field', slug: 'required_field')

        %w[boolean email integer string url].each do |field_classification|
          create(:field, collection: collection,
                         classification: field_classification,
                         label: "#{field_classification.titleize} Field",
                         slug: "#{field_classification}_field")
        end

        visit "/admin/collections/#{collection.id}/entries/new"
      end

      it 'fails without value for required field' do
        fill_in 'Required Field', with: ''
        click_button 'Create Entry'

        expect(page.find('.form-group.collection_entry_required_field'))
          .to have_content("can't be blank")
      end

      it 'fails without valid email for email field' do
        fill_in 'Required Field', with: 'Amazing Required Value'
        fill_in 'Email Field', with: 'me_at_email_dot_com'
        click_button 'Create Entry'

        expect(page.find('.form-group.collection_entry_email_field'))
          .to have_content('is not a valid email')
      end

      it 'fails without valid integer for integer field' do
        fill_in 'Required Field', with: 'Amazing Required Value'
        fill_in 'Integer Field', with: 'One'
        click_button 'Create Entry'

        expect(page.find('.form-group.collection_entry_integer_field'))
          .to have_content('not a valid integer')
      end

      it 'fails without valid URL for url field' do
        fill_in 'Required Field', with: 'Amazing Required Value'
        fill_in 'Url Field', with: 'not a valid URL'
        click_button 'Create Entry'

        expect(page.find('.form-group.collection_entry_url_field'))
          .to have_content('is invalid')
      end
    end
  end
end
