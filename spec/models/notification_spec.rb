require 'rails_helper'

RSpec.describe Notification, type: :model do

  it { should validate_presence_of :subject }
  it { should validate_presence_of :content }

  context "has GlobalID" do
    let(:data) {
      {
        subject: "Test",
        content: "Test"
      }
    }

    let(:encoded_data) {
      Base64.strict_encode64(data.to_json)
    }

    it "should able to return identification id" do
      notification = Notification.new(data)
      expect(notification.id).to eq(encoded_data)
    end

    it "should able to convert id into data" do
      notification = Notification.find(encoded_data)
      expect(notification.subject).to eq(data[:subject])
      expect(notification.content).to eq(data[:content])
    end
  end

  context "generate html content" do
    it "should able to convert markdown into html" do
      notification = Notification.new(content: "#heading")
      # TODO: Using capybara matcher
      expect(notification.html_content).to match(/<h1>heading<\/h1>/)
    end

    it "should able to modify content before convert to html" do
      notification = Notification.new
      expect(notification.html_content { "#heading" }).to match(/<h1>heading<\/h1>/)
    end
  end

end
