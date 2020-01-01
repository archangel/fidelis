# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Unauthorized (JSON)', type: :request do
  # let(:client) { create(:client) }
  #
  # before do
  #   client
  #
  #   sign_in(profile)
  # end
  #
  # describe 'when unauthorized (not a superadmin)' do
  #   let(:profile) { create(:ctrlr, :authy) }
  #
  #   before { create(:client_ctrlr, client: client, ctrlr: profile) }
  #
  #   it 'returns 401' do
  #     get '/trackers', headers: { accept: 'application/json' }
  #
  #     expect(response).to have_http_status(:unauthorized)
  #   end
  #
  #   it 'returns 401 with JSON schema' do
  #     get '/trackers', headers: { accept: 'application/json' }
  #
  #     expect(response).to match_response_schema('errors/unauthorized')
  #   end
  # end
end
