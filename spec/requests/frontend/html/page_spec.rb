# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frontend - Page (HTML)', type: :request do
  describe 'with homepage?' do
    it 'redirects to root path when Site homepage_redirect is true' do
      create(:site, homepage_redirect: true)
      create(:page, :homepage, slug: 'amazing')

      get '/amazing'

      expect(response).to redirect_to('/')
    end

    it 'returns 301 status when Site homepage_redirect is true' do
      create(:site, homepage_redirect: true)
      create(:page, :homepage, slug: 'amazing')

      get '/amazing'

      expect(response).to have_http_status(:moved_permanently)
    end

    it 'throws 404 when Site homepage_redirect is false' do
      create(:site, homepage_redirect: false)
      create(:page, :homepage, slug: 'amazing')

      get '/amazing'

      expect(response).to have_http_status(:not_found)
    end
  end
end
