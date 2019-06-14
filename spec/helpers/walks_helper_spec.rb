require 'rails_helper'

RSpec.describe WalksHelper, type: :helper do
  describe 'walks_public_status_helper' do
    it 'returns walk if no stations are created' do
      user = create(:user, username: 'foo')
      walk = create(:walk, courseline: '[[12, 12], [12.1, 12]]', public: false)
      expect(helper.walks_public_status_helper(walk)).to eq('walk')
    end

    it 'returns station if at least 2 stations were created' do
      user = create(:user, username: 'foo')
      walk = create(:walk, courseline: '[[12, 12], [12.1, 12]]', public: false)
      stations = create_list(:station, 2, walk: walk, user: user)

      expect(helper.walks_public_status_helper(walk)).to eq('station')
    end

    it 'returns courseline if courseline was set' do
      user = create(:user, username: 'foo')
      walk = create(:walk, courseline: '[[12, 12], [12.1, 12]]', public: false)
      stations = create_list(:station, 2, walk: walk, user: user)
      subject1 = create(:subject, station: stations.first, user: user)
      page1 = create(:page, subject: subject1, user: user)
      subject2 = create(:subject, station: stations.last, user: user)
      page2 = create(:page, subject: subject2, user: user)
      expect(helper.walks_public_status_helper(walk)).to eq('courseline')
    end

    it 'returns subject if subject was created' do
      user = create(:user, username: 'foo')
      walk = create(:walk, courseline: '[[12, 12], [12.1, 12]]', public: false)
      stations = create_list(:station, 2, walk: walk, user: user)
      subject1 = create(:subject, station: stations.first, user: user)
      page1 = create(:page, subject: subject1, user: user)
      subject2 = create(:subject, station: stations.last, user: user)

      expect(helper.walks_public_status_helper(walk)).to eq('subject')
    end

    it 'returns page if page was created' do
      user = create(:user, username: 'foo')
      walk = create(:walk, courseline: nil, public: false)
      stations = create_list(:station, 2, walk: walk, user: user)
      subject1 = create(:subject, station: stations.first, user: user)
      page1 = create(:page, subject: subject1, user: user)
      subject2 = create(:subject, station: stations.last, user: user)
      page2 = create(:page, subject: subject2, user: user)

      expect(helper.walks_public_status_helper(walk)).to eq('page')
    end
  end
end
