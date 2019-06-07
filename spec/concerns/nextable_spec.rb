require 'rails_helper'

shared_examples_for "nextable" do
  describe "set_next" do
    let(:model) { described_class } # the class that includes the concern
    it "is not last in collection" do
      station = FactoryBot.build(model.to_s.underscore.to_sym, priority: 2)
      station.set_next(10)
      expect(station.next).to eq(3)
    end

    it "is last in collection" do
      station = FactoryBot.build(model.to_s.underscore.to_sym, priority: 5)
      station.set_next(5)
      expect(station.next).to eq(nil)
    end
  end
end

shared_examples_for "nextable_walk" do
  describe "set_next_on_collection!" do
    let(:model) { described_class } # the class that includes the concern
    it "assigns next on every item in collection" do
      user = build(:user)
      walk = build(model.to_s.underscore.to_sym, user: user)

      stations = Array.new
      (1...4).each_with_index do |v, i|
        stations.push(build(:station, walk: walk, user: user, priority: i))
      end

      walk.set_next_on_collection!(stations)
      expect(stations.first.next).to eq(1)
      expect(stations.last.next).to eq(nil)
    end
  end
end

shared_examples_for "nextable_subject" do
  describe "set_next_on_collection!" do
    let(:model) { described_class } # the class that includes the concern
    it "assigns next on every item in collection" do
      user = build(:user)
      walk = build(:walk, user: user)
      station = build(:station, walk: walk, user: user)
      subject = build(model.to_s.underscore.to_sym,
                      user: user,
                      station: station)

      pages = Array.new
      (1...4).each_with_index do |v, i|
        pages.push(build(:page, subject: subject, user: user, priority: i))
      end

      subject.set_next_on_collection!(pages)
      expect(pages.second.next).to eq(2)
      expect(pages.last.next).to eq(nil)
    end
  end

  describe "set_prev_on_collection!" do
    let(:model) { described_class }
    it "assigns prev on every item in the collection" do
      user = build(:user)
      walk = build(:walk, user: user)
      station = build(:station, walk: walk, user: user)
      subject = build(model.to_s.underscore.to_sym,
                      user: user,
                      station: station)

      pages = Array.new
      (1...4).each_with_index do |v, i|
        pages.push(build(:page, subject: subject, user: user, priority: i))
      end

      subject.set_prev_on_collection!(pages)
      expect(pages.first.prev).to eq(nil)
      expect(pages.second.prev).to eq(0)
      expect(pages.third.prev).to eq(1)
    end
  end
end
