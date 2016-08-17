require 'rails_helper'

RSpec.describe "Admin::Papers", type: :request do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:activity) { FactoryGirl.create(:activity) }
  let(:paper) { FactoryGirl.create(:paper, activity: activity) }

  describe "GET /admin/activity/:id/papers" do
    it "cannot viewed by non admin user" do
      user = FactoryGirl.create(:user)
      login_as user
      visit admin_activity_papers_url(activity)
      expect(page).to have_content("Permission Denied")
    end

    it "display specify activity's proposal" do
      papers = FactoryGirl.create_list(:paper, 5, activity: activity)
      login_as admin
      visit admin_activity_papers_url(activity)
      papers.each do |paper|
        expect(page).to have_content(paper.title)
      end
    end
  end

  describe "GET /admin/activity/:id/papers/:id" do

    it "display paper's detail information" do
      login_as admin
      visit admin_activity_paper_url(activity, paper)

      expect(page).to have_content(paper.title)
      expect(page).to have_content(paper.abstract)
      expect(page).to have_content(paper.outline)
      expect(page).to have_content(paper.pitch)
    end
  end

  describe "POST /admin/papers/:id/reviews" do
    it "change paper state to reviewed" do
      paper = FactoryGirl.create(:paper, activity: activity)

      login_as admin
      visit admin_activity_papers_url(activity)

      within "#paper_#{paper.id}" do
        click_link "Review"
      end

      within "#paper_#{paper.id}" do
        expect(page).to have_content("Accept")
        expect(page).to have_content("Reject")
        expect(page).not_to have_content("Review")
      end
    end
  end

  describe "POST /admin/papers/:id/accept" do
    it "change paper state to accepted" do
      paper = FactoryGirl.create(:paper, :reviewed, activity: activity)

      login_as admin
      visit admin_activity_papers_url(activity)

      within "#paper_#{paper.id}" do
        click_link "Accept"
      end

      within "#paper_#{paper.id}" do
        expect(page).not_to have_content("Accept")
        expect(page).not_to have_content("Reject")
        expect(page).not_to have_content("Review")
      end
    end
  end

  describe "POST /admin/papers/:id/reject" do
    it "change paper state to rejected" do
      paper = FactoryGirl.create(:paper, :reviewed, activity: activity)

      login_as admin
      visit admin_activity_papers_url(activity)

      within "#paper_#{paper.id}" do
        click_link "Reject"
      end

      within "#paper_#{paper.id}" do
        expect(page).not_to have_content("Accept")
        expect(page).not_to have_content("Reject")
        expect(page).not_to have_content("Review")
      end
    end
  end

  describe "edit tag fields" do
    before(:each) do
      @paper = FactoryGirl.create(:paper, :reviewed, activity: activity)
      login_as admin
      visit admin_activity_papers_url(activity)
    end

    it "edit button exist" do
      expect(page).to have_content("edit tag")
      expect(page).to have_css("a.edit-tag-button")
    end

    it "render form after clicking button" do
      #find("#paper_#{@paper.id} .edit-tag-button").click
      #find("#paper_#{@paper.id} .add-tag-field").click
      #expect(page).to have_css(".edit-tag-button")
    end

    it "update tags" do
      #find("#paper_#{@paper.id} .edit-tag-button").click
      #within ".add-tag-field" do
      #  fill_in "Tag list", with: "abc, foo"
      #  click_button "Save"
      #end
      #expect(page).to have_content("abc")
      #expect(page).to have_content("foo")
    end

    it "do not render second form while clicking button" do
      #2.times{ find("#paper_#{@paper.id} .edit-tag-button").click }
      #...
    end

    it "put tab_list into values if tags already exist" do
      #...
    end

    it "remove form when clicking close button" do
      #...
    end
  end

  describe "comments" do
    before(:each) do
      @paper = FactoryGirl.create(:paper, :reviewed, activity: activity)
      login_as admin
      visit admin_activity_paper_url(activity, @paper)
    end

    it "create new comments" do
      within "form#new_comment" do
        fill_in "comment[text]", with: "Hello ruby!"
        click_on "Submit"
      end
      expect(page).to have_content("#{admin.name} says:")
      expect(page).to have_content("Hello ruby!")
      expect(page).to have_content("delete")
    end

    it "delete user's comments" do
      comment = FactoryGirl.create(:comment, paper: @paper, user:admin, text: "Hello rails!")
      visit admin_activity_paper_url(activity, @paper)
      within ".comment-#{comment.id}" do
        click_on "delete"
      end
       expect(page).not_to have_content("Hello rails!")
    end

    it "cannot delete other user's comment" do
      other_admin = FactoryGirl.create(:user, :admin)
      comment = FactoryGirl.create(:comment, paper: @paper, user: other_admin, text: "Hello Rspec!")
      visit admin_activity_paper_url(activity, @paper)
      expect(page).to have_content("Hello Rspec!")
      expect(page).not_to have_content("delete")
    end
  end


end
