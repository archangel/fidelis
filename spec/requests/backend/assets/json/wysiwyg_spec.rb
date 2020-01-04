# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend Assets wysiwyg (JSON)', type: :request do
  before { sign_in(profile) }

  let(:profile) { create(:user) }

  describe 'create' do
    let(:post_success_params) do
      {
        path: '',
        source: 'default',
        files: {
          '0' => fixture_file_upload('files/asset.png')
        }
      }
    end

    let(:post_failure_params) do
      {
        path: '',
        source: 'default',
        files: {
          '0' => fixture_file_upload('files/stylesheet.css')
        }
      }
    end

    it 'returns 200' do
      post '/admin/assets/wysiwyg', params: post_success_params,
                                    headers: { accept: 'application/json' }

      expect(response).to have_http_status(:ok)
    end

    it 'returns JSON schema with success' do
      post '/admin/assets/wysiwyg', params: post_success_params,
                                    headers: { accept: 'application/json' }

      expect(response)
        .to match_response_schema('backend/assets/wysiwyg/success')
    end

    it 'returns JSON schema with failure' do
      post '/admin/assets/wysiwyg', params: post_failure_params,
                                    headers: { accept: 'application/json' }

      expect(response)
        .to match_response_schema('backend/assets/wysiwyg/failure')
    end
  end
end
