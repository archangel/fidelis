# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frontend - Page (HTML)', type: :feature do
  describe '#show' do
    describe 'is available' do
      let(:page_design) do
        create(:design, content: '<p>This is the design</p>')
      end

      it 'finds the Page' do
        create(:page, slug: 'amazing', content: '<p>bonum est Deus</p>')

        visit '/amazing'

        expect(page).to have_content('bonum est Deus')
      end

      it 'finds the Page with a Design' do
        create(:page, design: page_design,
                      slug: 'amazing', content: '<p>bonum est Deus</p>')

        visit '/amazing'

        expect(page).to have_content('This is the design')
      end

      it 'finds the nested Page' do
        parent = create(:page, slug: 'amazing')
        create(:page, parent: parent,
                      slug: 'grace', content: '<p>bonum est Deus</p>')

        visit '/amazing/grace'

        expect(page).to have_content('bonum est Deus')
      end

      it 'finds the nested Page with a Design' do
        parent = create(:page, slug: 'amazing')
        create(:page, parent: parent, design: page_design,
                      slug: 'grace', content: '<p>bonum est Deus</p>')

        visit '/amazing/grace'

        expect(page).to have_content('This is the design')
      end
    end

    describe 'is not available' do
      it 'returns 404 when it does not exist' do
        visit '/licifer'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when homepage permalink is requested' do
        create(:page, :homepage, slug: 'coelum')

        visit '/coelum'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when the page is deleted' do
        create(:page, :deleted, slug: 'licifer')

        visit '/licifer'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when the page is not published' do
        create(:page, :unpublished, slug: 'periit')

        visit '/periit'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when the page is published for the future' do
        create(:page, :future, slug: 'futurae')

        visit '/futurae'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
