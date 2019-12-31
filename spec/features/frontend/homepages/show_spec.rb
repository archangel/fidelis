# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frontend - Homepage (HTML)', type: :feature do
  describe '#show' do
    describe 'is available' do
      let(:page_design) do
        create(:design, content: '<p>This is the design</p>')
      end

      it 'finds the Homepage' do
        create(:page, :homepage, content: '<p>bonum est Deus</p>')

        visit '/'

        expect(page).to have_content('bonum est Deus')
      end

      it 'finds the Homepage with a Design' do
        create(:page, :homepage, design: page_design,
                                 content: '<p>bonum est Deus</p>')

        visit '/'

        expect(page).to have_content('This is the design')
      end

      it 'finds the Homepage when it is nested' do
        parent = create(:page)
        create(:page, :homepage, parent: parent,
                                 content: '<p>bonum est Deus</p>')

        visit '/'

        expect(page).to have_content('bonum est Deus')
      end

      it 'finds the Homepage with a Design when it is nested' do
        parent = create(:page)
        create(:page, :homepage, parent: parent, design: page_design,
                                 content: '<p>bonum est Deus</p>')

        visit '/'

        expect(page).to have_content('This is the design')
      end
    end

    describe 'is not available' do
      it 'returns 404 when no Homepage exists' do
        visit '/'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when the Homepage is deleted' do
        create(:page, :homepage, :deleted)

        visit '/'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when the Homepage is not published' do
        create(:page, :homepage, :unpublished)

        visit '/'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns 404 when the Homepage is published for the future' do
        create(:page, :homepage, :future)

        visit '/'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
