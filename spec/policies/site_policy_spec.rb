# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SitePolicy, type: :policy do
  subject { described_class.new(profile, resource) }

  let(:resource) { create(:site) }

  context 'with admin Users' do
    let(:profile) { create(:user, :with_admin_role) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_edit_and_update_actions }

    it { is_expected.not_to permit_actions(%i[index destroy]) }
    it { is_expected.not_to permit_new_and_create_actions }
  end

  context 'with editor Users' do
    let(:profile) { create(:user, :with_editor_role) }

    it { is_expected.to permit_action(:show) }

    it { is_expected.not_to permit_edit_and_update_actions }

    it { is_expected.not_to permit_actions(%i[index destroy]) }
    it { is_expected.not_to permit_new_and_create_actions }
  end
end
