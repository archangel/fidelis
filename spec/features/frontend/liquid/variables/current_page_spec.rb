# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom variable', type: :feature do
  describe 'for `current_page` variable' do
    let(:inline_page) do
      %(
        {% if current_page == '/amazing' %}
          Amazing Page?: Yup!
        {% else %}
          Amazing Page?: Nope!
        {% endif %}
      )
    end

    it 'knows the current page at root level' do
      create(:page, slug: 'amazing',
                    content: 'Current Page: {{ current_page }}')

      visit '/amazing'

      expect(page).to have_content('Current Page: /amazing')
    end

    it 'knows the current page at nested level' do
      parent_resource = create(:page, slug: 'amazing')
      create(:page, parent: parent_resource,
                    slug: 'grace', content: 'Current Page: {{ current_page }}')

      visit '/amazing/grace'

      expect(page).to have_content('Current Page: /amazing/grace')
    end

    it 'knows it is on the current page' do
      create(:page, slug: 'amazing', content: inline_page)

      visit '/amazing'

      expect(page).to have_content('Amazing Page?: Yup!')
    end

    it 'knows it is not on the current page' do
      create(:page, slug: 'grace', content: inline_page)

      visit '/grace'

      expect(page).to have_content('Amazing Page?: Nope!')
    end

    it 'knows the current page with all known slug characters' do
      slug = 'abcdefghijklmnopqrstuvwxyz0123456789-_'
      create(:page, slug: slug, content: 'Current Page: {{ current_page }}')

      visit "/#{slug}"

      expect(page).to have_content("Current Page: /#{slug}")
    end
  end
end
