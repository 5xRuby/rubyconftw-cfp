require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }

  before(:each) do
    login_as admin
  end

  describe "GET /admin/users" do
    it "cannot view users when user is not admin" do
      login_as user
      visit admin_users_url
      expect(page).to have_content("Permission Denied")
    end

    it "list all signup users" do
      users = FactoryBot.create_list(:user, 5)

      visit admin_users_url
      expect(page).to have_content(admin.name)
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
  end

  describe "GET /admin/users/:id/designate" do
    it "assign user as admin" do
      normal_user = FactoryBot.create(:user)

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
      admin_user = FactoryBot.create(:user, :admin)

      visit admin_users_url
      within "#user_#{admin_user.id}" do
        click_link "undesignate to be admin"
      end

      within "#user_#{admin_user.id}" do
        expect(page).to have_content("designate to be admin")
      end
    end
  end

  describe "POST /admin/users/:id/contributor" do
    it "assign user as contributor" do
      user = FactoryBot.create(:user)

      visit admin_users_url
      within "#user_#{user.id}" do
        click_link "Mark as contributor"
      end

      within "#user_#{user.id}" do
        expect(page).to have_content("Unmark as contributor")
      end
    end
  end

  describe "DELETE /admin/users/:id/contributor" do
    it "unassign user as contributor" do
      user = FactoryBot.create(:user, :contributor)

      visit admin_users_url

      within "#user_#{user.id}" do
        click_link("Unmark as contributor")
      end

      within "#user_#{user.id}" do
        expect(page).to have_content("Mark as contributor")
      end
    end
  end

end
