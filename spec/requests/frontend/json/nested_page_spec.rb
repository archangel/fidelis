# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frontend - Page (JSON)', type: :request do
  describe '#show' do
    describe 'is available' do
      let(:parent_page) { create(:page, slug: 'amazing') }

      it 'returns successfully with JSON schema' do
        create(:page, parent: parent_page, slug: 'grace')

        get '/amazing/grace', headers: { accept: 'application/json' }

        expect(response).to match_response_schema('frontend/pages/show')
      end

      it 'finds the Page' do
        create(:page, parent: parent_page, slug: 'grace')

        get '/amazing/grace', headers: { accept: 'application/json' }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
