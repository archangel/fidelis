# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Widget (HTML)', type: :feature do
  def fill_in_widget_form_with(fields = {})
    design = fields.fetch(:design, '')

    fill_in 'Name', with: fields.fetch(:name, '')
    fill_in 'Slug', with: fields.fetch(:slug, '')
    select design, from: 'Design', match: :first if design.present?
    fill_in 'Content', with: fields.fetch(:content, '')
  end

  def fill_in_and_submit_widget_form_with(fields = {})
    fill_in_widget_form_with(fields)

    click_button 'Create Widget'
  end

  describe '#new' do
    before do
      sign_in(profile)

      create(:widget, name: 'Amazing', slug: 'amazing')
    end

    let(:profile) { create(:user) }

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/widgets/new'

        fill_in_and_submit_widget_form_with(name: 'Grace', slug: 'grace',
                                            content: 'Content')

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'successful without slug (uses slugged Name)' do
        visit '/admin/widgets/new'

        fill_in_and_submit_widget_form_with(name: 'Grace', slug: '',
                                            content: 'Content')

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'is displays success message with valid data with Design' do
        create(:design, name: 'Tpl', partial: true)

        visit '/admin/widgets/new'

        fill_in_and_submit_widget_form_with(name: 'Grace', slug: 'grace',
                                            content: 'Content', design: 'Tpl')

        expect(page).to have_content('Widget was successfully created.')
      end
    end

    describe 'unsuccessful' do
      it 'fails without name' do
        visit '/admin/widgets/new'

        fill_in_and_submit_widget_form_with(name: '', slug: 'grace',
                                            content: 'Content')

        expect(page.find('.string.widget_name'))
          .to have_content("can't be blank")
      end

      it 'fails with used slug' do
        visit '/admin/widgets/new'

        fill_in_and_submit_widget_form_with(name: 'Grace', slug: 'amazing',
                                            content: 'Content')

        expect(page.find('.string.widget_slug'))
          .to have_content('has already been taken')
      end

      it 'fails without content' do
        visit '/admin/widgets/new'

        fill_in_and_submit_widget_form_with(name: 'Grace', slug: 'grace',
                                            content: '')

        expect(page.find('.wysiwyg.widget_content'))
          .to have_content("can't be blank")
      end
    end
  end
end
