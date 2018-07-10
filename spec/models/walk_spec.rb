require 'rails_helper'

RSpec.describe Walk, type: :model do
  it { should have_many(:stations).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:description) }
end
