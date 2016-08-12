require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  describe "GET /admin/users" do
    it "cannot view users when user is not admin" do
      login_as user
      visit admin_users_url
      expect(page).to have_content("Permission Denied")
    end

    it "list all signup users" do
      users = FactoryGirl.create_list(:user, 5)

      login_as admin
      visit admin_users_url
      expect(page).to have_content(admin.name)
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
  end

  describe "GET /admin/users/:id/designate" do
    it "assign user as admin" do
      normal_user = FactoryGirl.create(:user)

      login_as admin
      visit admin_users_url
      within "#user_#{normal_user.id}" do
        click_link "designate to be admin"
      end

      # NOTICE: below code is click link and new rendered page
      within "#user_#{normal_user.id}" do
        expect(page).to have_content("undesignate to be admin")
      end
    end
  end

  describe "GET /admin/users/:id/undesignate" do
    it "unassign user as admin" do
      admin_user = FactoryGirl.create(:user, :admin)

      login_as admin
      visit admin_users_url
      within "#user_#{admin_user.id}" do
        click_link "undesignate to be admin"
      end

      within "#user_#{admin_user.id}" do
        expect(page).to have_content("designate to be admin")
      end
    end
  end

end
