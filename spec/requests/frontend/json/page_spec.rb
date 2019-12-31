# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frontend - Page (JSON)', type: :request do
  describe '#show' do
    describe 'is available' do
      it 'returns successfully with JSON schema' do
        create(:page, slug: 'amazing')

        get '/amazing', headers: { accept: 'application/json' }

        expect(response).to match_response_schema('frontend/pages/show')
      end

      it 'finds the Page' do
        create(:page, slug: 'amazing')

        get '/amazing', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:ok)
      end
    end

    describe 'is not available' do
      it 'returns 404 with JSON schema' do
        get '/unknown', headers: { accept: 'application/json' }

        expect(response).to match_response_schema('frontend/errors/not_found')
      end

      it 'returns 404 when no Page exists' do
        get '/unknown', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 404 when the Page is deleted' do
        create(:page, :deleted, slug: 'amazing')

        get '/amazing', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 404 when the Page is not published' do
        create(:page, :unpublished, slug: 'amazing')

        get '/amazing', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 404 when the Page is published for the future' do
        create(:page, :future, slug: 'amazing')

        get '/amazing', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
