require 'rails_helper'
require Rails.root.join "spec/concerns/nextable_spec.rb"

RSpec.describe Walk, type: :model do
  it_behaves_like "nextable_walk"

  it { should have_many(:stations).dependent(:destroy) }
  it { should belong_to(:user)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:description) }

  it 'scopes public walks' do
    user = create(:user)
    pub1 = create(:walk, public: true, name: 'Public 1', user: user)
    pub2 = create(:walk, public: true, name: 'Public 2', user: user)
    priv1 = create(:walk, name: 'Private 1', user: user)
    priv2 = create(:walk, name: 'Private 2', user: user)

    expect(Walk.is_public).to eq([pub1, pub2])
    expect(Walk.is_public).to_not eq([pub1, pub2, priv1, priv2])
  end

  it 'is editable by its creator' do
    user = create(:user)
    walk = create(:walk, user: user)
    current_user = user
    expect(walk.editable_by? current_user).to eq true
  end
  it 'is editable by  admin' do
    admin = create(:user, admin: true)
    walk = create(:walk)
    current_user = admin
    expect(walk.editable_by? current_user).to eq true
  end
  it 'is not editable by others' do
    user = create(:user)
    walk = create(:walk)
    current_user = user
    expect(walk.editable_by? current_user).to eq false
  end

  it 'is not publishable if it is already public' do
    walk = create(:walk, public: true)
    expect(walk.publishable?).to eq false
  end

  it 'is publishable if all other conditions are met' do
    user = create(:user, username: 'foo')
    walk = create(:walk, courseline: '[[12, 12], [12.1, 12]]', public: false)
    stations = create_list(:station, 2, walk: walk, user: user)
    subjects = create_list(:subject, 2, station: stations.first, user: user)
    page = create(:page, subject: subjects.first, user: user)
    expect(walk.publishable?).to eq true
  end
end
