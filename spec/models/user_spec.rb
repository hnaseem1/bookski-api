require 'rails_helper'

# Test suite for the User model
RSpec.describe User, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  #it { should have_many(:channels).dependent(:destroy) }
  # Validation tests
  # ensure columns username is present before saving
  it { should validate_presence_of(:username) }
end