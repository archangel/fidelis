# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Site (HTML)', type: :feature do
  describe '#show' do
    # before { stub_authorization! }

    describe 'is available' do
      before { create(:site, name: 'Amazing Site') }

      it 'finds the Site name' do
        visit '/admin/site'

        expect(page).to have_content('Name: Amazing Site')
      end
    end

    describe 'is not available' do
      it 'creates a new Site' do
        visit '/admin/site'

        expect(page).to have_content('Name: Archangel')
      end
    end
  end
end
