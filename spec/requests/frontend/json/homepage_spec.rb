# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frontend - Homepage (JSON)', type: :request do
  describe '#show' do
    describe 'is available' do
      it 'returns successfully with JSON schema' do
        create(:page, :homepage)

        get '/', headers: { accept: 'application/json' }

        expect(response).to match_response_schema('frontend/pages/show')
      end

      it 'finds the Homepage' do
        create(:page, :homepage)

        get '/', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:ok)
      end
    end

    describe 'is not available' do
      it 'returns 404 with JSON schema' do
        get '/', headers: { accept: 'application/json' }

        expect(response).to match_response_schema('frontend/errors/not_found')
      end

      it 'returns 404 when no Homepage exists' do
        get '/', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 404 when the Homepage is deleted' do
        create(:page, :homepage, :deleted)

        get '/', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 404 when the Homepage is not published' do
        create(:page, :homepage, :unpublished)

        get '/', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 404 when the Homepage is published for the future' do
        create(:page, :homepage, :future)

        get '/', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
