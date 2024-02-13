  require 'rails_helper'

RSpec.describe "Admin::Papers", type: :request do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:activity) { FactoryBot.create(:activity) }
  let(:state) { :submitted }

  before(:each) do
    @paper = FactoryBot.create(:paper, activity: activity, state: state)
    login_as admin
  end

  describe "GET /admin/activity/:id/papers" do
    before(:each) do
      @papers = FactoryBot.create_list(:paper, 5, activity: activity)
      visit admin_activity_papers_url(activity)
    end

    it "cannot viewed by non admin user" do
      user = FactoryBot.create(:user)
      login_as user
      visit admin_activity_papers_url(activity)
      expect(page).to have_content("Permission Denied")
    end

    it "display specify activity's proposal" do
      @papers.each do |paper|
        expect(page).to have_content(paper.title)
      end
    end
  end

  describe "GET /admin/activity/:id/papers/:id" do
    before do
      login_as admin
      visit admin_activity_paper_url(activity, @paper)
    end

    %w{title abstract outline pitch}.each do |f|
      it "displays paper's #{f}" do
        expect(page).to have_content(@paper.send(f))
      end
    end

  end

  describe "GET /admin/activities/:id/papers" do
    before do
      login_as admin
      visit admin_activity_papers_url(@paper.activity) #一次叫出 paper & activity
    end

    it "displays show and Approve/Disapprove before vote" do
      within "#paper_#{@paper.id}" do
        expect(page).to have_content("show")
        expect(page).to have_content("Approve")
        expect(page).to have_content("Disapprove")
      end
    end
  end


  describe "POST /admin/papers/:id/approve" do
    before(:each) { visit admin_activity_papers_url(activity) }

    it "changes state to reviewed" do
      within "#paper_#{@paper.id}" do
        click_link("Approve")
      end

      within "#paper_#{@paper.id} .btn-group" do
        expect(page).not_to have_content("Approve")
        expect(page).not_to have_content("Disapprove")
      end
    end

    it "adds 1 vote on approve" do
      within "#paper_#{@paper.id}" do
        click_link("Approve")
      end

      within "#paper_#{@paper.id} .approve-vote-count" do
        expect(page).to have_content("1")
      end
    end
  end

  describe "POST /admin/papers/:id/disapprove" do
    before(:each) { visit admin_activity_papers_url(activity) }

    it "changes state to reviewed" do
      within "#paper_#{@paper.id}" do
        click_link("Disapprove")
      end

      within "#paper_#{@paper.id} .btn-group" do
        expect(page).not_to have_content("Approve")
        expect(page).not_to have_content("Disapprove")
      end
    end

    it "adds 1 vote on approve" do
      within "#paper_#{@paper.id}" do
        click_link("Disapprove")
      end

      within "#paper_#{@paper.id} .disapprove-vote-count" do
        expect(page).to have_content("1")
      end
    end
  end

  describe "POST /admin/papers/:id/accept" do
    let(:state) { :reviewed }
    before(:each) { visit admin_activity_papers_url(activity) }

    it "change paper state to accepted" do
      within "#paper_#{@paper.id}" do
        click_link "Accept"
      end

      within "#paper_#{@paper.id}" do
        expect(page).not_to have_content("Accept")
        expect(page).not_to have_content("Reject")
        expect(page).not_to have_content("Review")
      end
    end
  end

  describe "POST /admin/papers/:id/reject" do
    let(:state) { :reviewed }
    before(:each) { visit admin_activity_papers_url(activity) }

    it "change paper state to rejected" do
      within "#paper_#{@paper.id}" do
        click_link "Reject"
      end

      within "#paper_#{@paper.id}" do
        expect(page).not_to have_content("Accept")
        expect(page).not_to have_content("Reject")
        expect(page).not_to have_content("Review")
      end
    end
  end

  describe "edit tag fields" do
    before(:each) do
      @paper = FactoryBot.create(:paper, :reviewed, activity: activity)
      login_as admin
      visit admin_activity_paper_url(activity, @paper)
    end

    it "edit button exist" do
      expect(page).to have_content("Edit tag")
      expect(page).to have_css("a.edit-tag-button")
    end

    it "update tags" do
      within ".add-tag-field" do
        fill_in "Tag list", with: "abc, foo"
        click_button "Save"
      end
      expect(page).to have_content("abc")
      expect(page).to have_content("foo")
    end

    it "put tab_list into values if tags already exist" do
      @paper.update(tag_list: %w(owo qwq))
      visit admin_activity_paper_url(activity, @paper)
      expect(page).to have_field('paper[tag_list]', with: "owo, qwq")
    end

    it "show tags on index page" do
      @paper.update(tag_list: %w(excellent))
      visit admin_activity_papers_url(activity)
      expect(page).to have_content("excellent")
    end

  end

  describe "comments" do
    before(:each) do
      @paper = FactoryBot.create(:paper, :reviewed, activity: activity)
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
      comment = FactoryBot.create(:comment, paper: @paper, user:admin, text: "Hello rails!")
      visit admin_activity_paper_url(activity, @paper)
      within ".comment-#{comment.id}" do
        click_on "delete"
      end
       expect(page).not_to have_content("Hello rails!")
    end

    it "cannot delete other user's comment" do
      other_admin = FactoryBot.create(:user, :admin)
      FactoryBot.create(:comment, paper: @paper, user: other_admin, text: "Hello Rspec!")
      visit admin_activity_paper_url(activity, @paper)
      expect(page).to have_content("Hello Rspec!")
      expect(page).not_to have_content("delete")
    end
  end


end
