require 'rails_helper'
require Rails.root.join "spec/concerns/nextable_spec.rb"

RSpec.describe Subject, type: :model do
  it_behaves_like "nextable_subject"

  it { should belong_to(:station) }
  it { should have_many(:pages).dependent(:destroy) }
  it { should belong_to(:user)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
