require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should belong_to(:subject) }
  it { should belong_to(:user)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:variant) }
end
