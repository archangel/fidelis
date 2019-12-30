# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context 'with #frontend_resource_path' do
    it 'returns the permalink with a string' do
      expect(helper.frontend_resource_path('foo/bar')).to eq('/foo/bar')
    end

    it 'returns the permalink with a Page resource' do
      parent = create(:page, slug: 'foo')
      page = create(:page, parent: parent, slug: 'bar')

      expect(helper.frontend_resource_path(page)).to eq('/foo/bar')
    end
  end
end
