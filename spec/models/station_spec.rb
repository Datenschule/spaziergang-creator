require 'rails_helper'

RSpec.describe Station, type: :model do
  it { should belong_to(:walk) }
  it { should have_many(:subjects).dependent(:destroy) }
  it { should belong_to(:user)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lon) }
end
