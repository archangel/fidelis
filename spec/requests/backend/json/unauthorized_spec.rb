# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Unauthorized (JSON)', type: :request do
  before do
    create(:site)

    sign_in(profile)
  end

  describe 'when unauthorized (not an admin)' do
    let(:profile) { create(:user, :with_editor_role) }

    it 'returns 401' do
      get '/admin/site/edit', headers: { accept: 'application/json' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 with JSON schema' do
      get '/admin/site/edit', headers: { accept: 'application/json' }

      expect(response).to match_response_schema('backend/errors/unauthorized')
    end
  end
end
