shared_context 'ability' do
  let(:ability) { Ability.new(user) }
  let(:user) { create(:user) }

  before do
    allow(@controller).to receive(:current_user).and_return(user)
  end

  def reload_ability(current_ability)
    allow(subject).to receive(:current_ability).and_return(current_ability)
  end
end
