require 'rails_helper'
require Rails.root.join "spec/concerns/nextable_spec.rb"

RSpec.describe Page, type: :model do
  it_behaves_like "nextable"

  it { should belong_to(:subject) }
  it { should belong_to(:user)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:variant) }
end
