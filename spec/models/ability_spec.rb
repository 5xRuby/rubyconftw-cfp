require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject { Ability.new(user) }
  let(:user) { FactoryBot.create(:user) }

  it { should be_able_to(:manage, Paper.new(user: user)) }
  it { should be_able_to(:read, FactoryBot.create(:user)) }
  it { should be_able_to(:edit, user) }
  it { should be_able_to(:read, Activity.new) }

  context "when is an admin" do
    let(:user) { FactoryBot.create(:user, is_admin: true) }
    it { should be_able_to(:read, Paper.new) }
  end
end
