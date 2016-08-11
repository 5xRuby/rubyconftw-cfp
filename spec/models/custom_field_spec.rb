require 'rails_helper'

RSpec.describe CustomField, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sort_order) }
  it { should validate_presence_of(:field_type) }

  context "include collection" do
    let(:collection) { ["A", "B", "C"] }

    it "should able to convert collection into string" do
      custom_field = CustomField.new(collection: collection)
      expect(custom_field.collection_text).to eq(collection.join(CustomField::DELIMITER))
    end

    it "should able to convert string into collection" do
      custom_field = CustomField.new
      custom_field.collection_text = collection.join(CustomField::DELIMITER)
      expect(custom_field.collection).to eq(collection)
    end
  end

end
