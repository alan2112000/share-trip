require 'rails_helper'

RSpec.describe Trip, type: :model do
  it { should have_many(:locations) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
end
