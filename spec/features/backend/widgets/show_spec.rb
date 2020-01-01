# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Widget (HTML)', type: :feature do
  describe '#show' do
    before { sign_in(profile) }

    let(:profile) { create(:user) }

    describe 'is available' do
      let(:resource) do
        create(:widget, name: 'Amazing Widget', slug: 'amazing')
      end

      it 'finds the Widget name' do
        visit "/admin/widgets/#{resource.id}"

        expect(page).to have_content('Name: Amazing Widget')
      end
    end

    describe 'is not available' do
      it 'returns 404 when it does not exist' do
        visit '/admin/widgets/0'

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end

      it 'returns error message when it is deleted' do
        resource = create(:widget, :deleted)

        visit "/admin/widgets/#{resource.id}"

        expect(page)
          .to have_content('Page not found. Could not find what was requested')
      end
    end
  end
end
