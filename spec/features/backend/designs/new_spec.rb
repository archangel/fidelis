# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Design (HTML)', type: :feature do
  def fill_in_design_form_with(fields = {})
    parent = fields.fetch(:parent, '')

    fill_in 'Name', with: fields.fetch(:name, '')
    select parent, from: 'Parent', match: :first if parent.present?
    fill_in 'Content', with: fields.fetch(:content, '')
    fields.fetch(:partial, false) ? check('Partial') : uncheck('Partial')
  end

  def fill_in_and_submit_design_form_with(fields = {})
    fill_in_design_form_with(fields)

    click_button 'Create Design'
  end

  describe '#new' do
    before do
      sign_in(profile)

      create(:design, name: 'Amazing')
    end

    let(:profile) { create(:user) }

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/designs/new'

        fill_in_and_submit_design_form_with(name: 'Grace', content: 'Content')

        expect(page).to have_content('Design was successfully created.')
      end

      it 'is displays success message with valid data with Design' do
        create(:design, name: 'Tpl', partial: true)

        visit '/admin/designs/new'

        fill_in_and_submit_design_form_with(name: 'Grace', content: 'Content',
                                            design: 'Tpl')

        expect(page).to have_content('Design was successfully created.')
      end
    end

    describe 'unsuccessful' do
      it 'fails without name' do
        visit '/admin/designs/new'

        fill_in_and_submit_design_form_with(name: '', content: 'Content')

        expect(page.find('.string.design_name'))
          .to have_content("can't be blank")
      end

      it 'fails without content' do
        visit '/admin/designs/new'

        fill_in_and_submit_design_form_with(name: 'Grace', content: '')

        expect(page.find('.text.design_content'))
          .to have_content("can't be blank")
      end
    end
  end
end
