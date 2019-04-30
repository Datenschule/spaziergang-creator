class Walk < ApplicationRecord
  has_many :stations, dependent: :destroy
  belongs_to :user

  validates_presence_of :name, :location, :description

  WALK_BASE_URL = ENV['WALK_APP_URL'] || "https://spaziergang.demokratielabore.de/"

  scope :is_public, -> { where(public: true) }

  def editable_by?(current_user)
    (current_user) && (user == current_user || current_user.admin?)
  end

  def publishable?
    stations.count >= 2 &&
      courseline.present? &&
      stations.first.subjects.present? &&
      stations.first.subjects.first.pages.present? &&
      !public
  end

  def link_in_frontend
    "#{WALK_BASE_URL}/course/#{id}"
  end

  def next_station_priority
    return stations.size
  end

  def set_next_on_all_stations!
    stations.each do |st|
      st.set_next stations.size
      st.save!
    end
  end
end
