require 'cancan/matchers'

describe Ability do
  describe 'abilities of signed in user' do
    let(:ability) { Ability.new(user) }
    let(:user) { create(:user) }
    let(:project) { create(:project, user: user) }
    let(:another_project) { create(:project) }

    subject { ability }

    context 'for projects' do
      it { is_expected.to be_able_to(:read, project) }
      it { is_expected.to be_able_to(:create, Project) }
      it { is_expected.to be_able_to(:update, project) }
      it { is_expected.to be_able_to(:destroy, project) }

      it { is_expected.not_to be_able_to(:read, another_project) }
      it { is_expected.not_to be_able_to(:update, another_project) }
      it { is_expected.not_to be_able_to(:destroy, another_project) }
    end
  end

  describe 'abilities of guest' do
    let(:ability) { Ability.new(user) }
    let(:user) { build(:user) }
    let(:project) { create(:project) }

    subject { ability }

    context 'for projects' do
      it { is_expected.not_to be_able_to(:read, project) }
      it { is_expected.not_to be_able_to(:create, Project) }
      it { is_expected.not_to be_able_to(:update, project) }
      it { is_expected.not_to be_able_to(:destroy, project) }
    end
  end
end
