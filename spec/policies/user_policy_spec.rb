# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(profile, resource) }

  let(:resource) { create(:user) }

  context 'with all Users' do
    let(:profile) { create(:user) }

    it { is_expected.to permit_actions(%i[index show destroy]) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
  end
end
