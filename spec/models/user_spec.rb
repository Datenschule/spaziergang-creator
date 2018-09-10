require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:walks) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }

  it 'does not allow @ in username' do
    expect(User.new(username: "foo@bar")).to_not be_valid
  end
end
