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

  it "generate yaml" do
    user = FactoryGirl.create(:user)
    except_yaml = %{---
- id: #{user.id}
  email: #{user.email}
  name: #{user.name}
  phone: #{user.phone}
}

    expect(User.all.as_yaml(only: [:id, :email, :name, :phone])).to eq(except_yaml)
  end

  it "generate yaml with root" do
    user = FactoryGirl.create(:user)
    except_yaml = %{---
users:
- id: #{user.id}
  email: #{user.email}
  name: #{user.name}
  phone: #{user.phone}
}

    expect(User.all.as_yaml(include_root: true, only: [:id, :email, :name, :phone])).to eq(except_yaml)
  end
end
