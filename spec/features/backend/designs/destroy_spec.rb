# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Design (HTML)', type: :feature do
  describe '#destroy' do
    before do
      # stub_authorization!

      create(:design, name: 'Delete Me')
      create(:design, name: 'Keep Me')
    end

    it 'displays success message' do
      visit '/admin/designs'

      within('tbody tr:eq(1)') { click_on 'Destroy' }

      expect(page).to have_content('Design was successfully destroyed.')
    end

    it 'does not list deleted Design' do
      visit '/admin/designs'

      within('tbody tr:eq(1)') { click_on 'Destroy' }

      within('tbody tr:eq(1)') do
        expect(page).not_to have_content('Delete Me')
      end
    end
  end
end