# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom variable', type: :feature do
  describe 'for unknown variables' do
    before do
      create(:page, slug: 'amazing',
                    content: 'Unknown Variable: ~{{ unknown_variable }}~')
    end

    it 'responds with blank value' do
      visit '/amazing'

      expect(page).to have_content('Unknown Variable: ~~')
    end
  end
end
