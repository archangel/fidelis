# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Page (HTML)', type: :feature do
  # rubocop:disable Metrics/AbcSize
  def fill_in_page_form_with(fields = {})
    parent = fields.fetch(:parent, '')
    design = fields.fetch(:design, '')

    fill_in 'Title', with: fields.fetch(:title, '')
    select parent, from: 'Parent', match: :first if parent.present?
    fill_in 'Slug', with: fields.fetch(:slug, '')
    select design, from: 'Design', match: :first if design.present?
    fill_in 'Content', with: fields.fetch(:content, '')
    fields.fetch(:homepage, false) ? check('Homepage') : uncheck('Homepage')
    fill_in 'Published At', with: fields.fetch(:published_at, Time.current)
  end
  # rubocop:enable Metrics/AbcSize

  def fill_in_and_submit_page_form_with(fields = {})
    fill_in_page_form_with(fields)

    click_button 'Create Page'
  end

  describe '#new' do
    before do
      # stub_authorization!

      create(:page, slug: 'amazing', title: 'Amazing')
    end

    describe 'successful' do
      it 'is displays success message with valid data' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'grace',
                                          content: 'Content')

        expect(page).to have_content('Page was successfully created.')
      end

      it 'successful without slug (uses slugged Title)' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: '',
                                          content: 'Content')

        expect(page).to have_content('Page was successfully created.')
      end

      it 'is displays success message with valid data with Parent' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'grace',
                                          content: 'Content', parent: 'Amazing')

        expect(page).to have_content('Page was successfully created.')
      end

      it 'is displays success message with valid data with Design' do
        create(:design, name: 'Design')

        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'grace',
                                          content: 'Content', design: 'Design')

        expect(page).to have_content('Page was successfully created.')
      end

      it 'is successful with duplicate slug at different levels' do
        create(:page, slug: 'grace')

        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'grace',
                                          content: 'Content', parent: 'Amazing')

        expect(page).to have_content('Page was successfully created.')
      end
    end

    describe 'unsuccessful' do
      it 'fails with invalid published_at date' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'grace',
                                          content: 'Content', published_at: 'a')

        expect(page.find('.string.page_published_at'))
          .to have_content('is not a date')
      end

      it 'fails without title' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: '', slug: 'grace',
                                          content: 'Content')

        expect(page.find('.string.page_title'))
          .to have_content("can't be blank")
      end

      it 'fails with used slug at same level' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'amazing',
                                          content: 'Content')

        expect(page.find('.string.page_slug'))
          .to have_content('has already been taken')
      end

      %w[admin].each do |reserved_path|
        it "fails with reserved slug of `#{reserved_path}`" do
          visit '/admin/pages/new'

          fill_in_and_submit_page_form_with(title: 'Grace', slug: reserved_path,
                                            content: 'Content')

          expect(page.find('.string.page_slug'))
            .to have_content('contains a restricted path')
        end
      end

      it 'fails without content' do
        visit '/admin/pages/new'

        fill_in_and_submit_page_form_with(title: 'Grace', slug: 'grace',
                                          content: '')

        expect(page.find('.text.page_content'))
          .to have_content("can't be blank")
      end
    end
  end
end
