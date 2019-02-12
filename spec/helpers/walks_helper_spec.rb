require 'rails_helper'
RSpec.describe WalksHelper, type: :helper do
  describe 'walks_public_status_helper' do
    it 'returns walk if no stations are created' do
      walk_mock = double(stations: false)
      expect(helper.walks_public_status_helper(walk_mock)).to eq('walk')
    end

    it 'returns station if at least 2 stations were created' do
      walk_mock = double(stations: double(
                           count: 2,
                           first: double(subjects: false)),
                           courseline: nil)
      expect(helper.walks_public_status_helper(walk_mock)).to eq('station')
    end

    it 'returns courseline if courseline was set' do
      walk_mock = double(stations: double(
                           first: double(subjects: double(
                                           first: double(
                                             pages: true))),
                           count: 2),
                         courseline: [[12, 12], [12, 12.1]])
      expect(helper.walks_public_status_helper(walk_mock)).to eq('courseline')
    end

    it 'returns subject if subject was created' do
      walk_mock = double(stations: double(
                           first: double(
                             subjects: double(
                               first: double(
                                 pages: false))),
                           count: 2),
                         courseline: nil)
      expect(helper.walks_public_status_helper(walk_mock)).to eq('subject')
    end

    it 'returns page if page was created' do
      walk_mock = double(stations: double(
                           first: double(subjects: double(
                                           first: double(
                                             pages: true))),
                           count: 2),
                         courseline: nil)
      expect(helper.walks_public_status_helper(walk_mock)).to eq('page')
    end
  end
end
