require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }

  context "sign in with omniauth" do
    let(:exists_user) { FactoryGirl.create(:user) }
    let(:auth_info) {
      OmniAuth::AuthHash.new({
        provider: 'github',
        info: {
          email: 'github@rubyconf.tw'
        }
      })
    }

    let(:auth_info_exists) {
      OmniAuth::AuthHash.new({
        provider: 'github',
        info: {
          email: exists_user.email
        }
      })
    }

    it "should create new user when not found" do
      user_count = User.count
      User.from_omniauth(auth_info)
      expect(user_count).not_to eq(User.count)
    end

    it "should return exists user when found" do
      expect(User.from_omniauth(auth_info_exists)).to eq(exists_user)
    end
  end
end
