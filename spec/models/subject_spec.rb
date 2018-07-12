require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should belong_to(:station) }
  it { should have_many(:pages) }
  it { should belong_to(:user)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
