require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe "notice" do
    let(:notification) {
      Notification.new(
        subject: "RubyConfTW",
        content: "Welcome to **<%= activity.name %>**"
      )
    }
    let(:activity) { Activity.new(name: "RubyConfTW") }
    let(:mail) { described_class.notice("test@rubyconf.tw", notification, { activity: activity }).deliver_now }

    it "renders the subject" do
      expect(mail.subject).to eq("RubyConfTW")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq(["test@rubyconf.tw"])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@rubyconf.test"])
    end

    it "renders the bcc email" do
      expect(mail.bcc).to eq(["contact@rubyconf.dev"])
    end

    it "assigns @activity.name" do
      expect(mail.body.encoded).to match(activity.name)
    end

    it "convert markdonw into html" do
      expect(mail.body.encoded).to match(/<strong>#{activity.name}<\/strong>/)
    end


  end
end
