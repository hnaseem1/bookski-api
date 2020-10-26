require 'rails_helper'

# Test suite for the Item model
RSpec.describe Channel, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should have_many(:channel_messages).dependent(:destroy)  }
  # Validation test
  # ensure column name is present before saving
  #it { should validate_uniqueness_of(:name) }
end