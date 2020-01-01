# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Profile (HTML)', type: :feature do
  describe '#show' do
    before { sign_in(profile) }

    let(:profile) { create(:user, name: 'Jesus Christ') }

    describe 'is available' do
      it 'finds the Profile name' do
        visit '/admin/profile'

        expect(page).to have_content('Name: Jesus Christ')
      end
    end
  end
end
