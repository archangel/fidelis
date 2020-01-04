# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Liquid custom variable', type: :feature do
  describe 'for request variables' do
    it 'knows the `domain`' do
      create(:page, slug: 'amazing',
                    content: 'Request Domain: {{ request.domain }}')

      visit '/amazing'

      expect(page).to have_content('Request Domain: example.com')
    end

    it 'knows the `fullpath`' do
      create(:page, slug: 'amazing',
                    content: 'Request Fullpath: {{ request.fullpath }}')

      visit '/amazing?a=1#foo'

      expect(page).to have_content('Request Fullpath: /amazing')
    end

    it 'knows the `host`' do
      create(:page, slug: 'amazing',
                    content: 'Request Host: {{ request.host }}')

      visit '/amazing'

      expect(page).to have_content('Request Host: www.example.com')
    end

    it 'knows the `path`' do
      create(:page, slug: 'amazing',
                    content: 'Request Path: {{ request.path }}')

      visit '/amazing?a=1#foo'

      expect(page).to have_content('Request Path: /amazing')
    end

    it 'knows the `protocol`' do
      create(:page, slug: 'amazing',
                    content: 'Request Protocol: {{ request.protocol }}')

      visit '/amazing'

      expect(page).to have_content('Request Protocol: http://')
    end

    it 'knows the `url`' do
      create(:page, slug: 'amazing',
                    content: 'Request URL: {{ request.url }}')

      visit '/amazing'

      expect(page).to have_content('Request URL: http://www.example.com')
    end
  end
end
