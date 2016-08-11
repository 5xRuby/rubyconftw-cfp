require 'rails_helper'

RSpec.describe CustomField, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sort_order) }
  it { should validate_presence_of(:field_type) }

end
