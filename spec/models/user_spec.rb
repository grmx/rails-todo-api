require 'rails_helper'

RSpec.describe User, type: :model do
  before { create(:user) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(128) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects).dependent(:destroy) }
  end
end
