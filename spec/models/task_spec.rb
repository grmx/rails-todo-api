require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project) }
  end
end
