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

    context 'for tasks' do
      let(:task) { create(:task, project: project)}
      let(:another_task) { create(:task, project: another_project)}

      it { is_expected.to be_able_to(:read, task) }
      it { is_expected.to be_able_to(:create, Task) }
      it { is_expected.to be_able_to(:update, task) }
      it { is_expected.to be_able_to(:destroy, task) }

      it { is_expected.not_to be_able_to(:read, another_task) }
      it { is_expected.not_to be_able_to(:update, another_task) }
      it { is_expected.not_to be_able_to(:destroy, another_task) }
    end

    context 'for comments' do
      let(:task) { create(:task, project: project)}
      let(:comment) { create(:comment, task: task)}
      let(:another_comment) { create(:comment)}

      it { is_expected.to be_able_to(:read, comment) }
      it { is_expected.to be_able_to(:create, Comment) }
      it { is_expected.to be_able_to(:update, comment) }
      it { is_expected.to be_able_to(:destroy, comment) }

      it { is_expected.not_to be_able_to(:read, another_comment) }
      it { is_expected.not_to be_able_to(:update, another_comment) }
      it { is_expected.not_to be_able_to(:destroy, another_comment) }
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

    context 'for tasks' do
      let(:task) { create(:task, project: project) }

      it { is_expected.not_to be_able_to(:read, task) }
      it { is_expected.not_to be_able_to(:create, Task) }
      it { is_expected.not_to be_able_to(:update, task) }
      it { is_expected.not_to be_able_to(:destroy, task) }
    end

    context 'for comments' do
      let(:task) { create(:task, project: project) }
      let(:comment) { create(:comment, task: task) }

      it { is_expected.not_to be_able_to(:read, comment) }
      it { is_expected.not_to be_able_to(:create, Comment) }
      it { is_expected.not_to be_able_to(:update, comment) }
      it { is_expected.not_to be_able_to(:destroy, comment) }
    end
  end
end
