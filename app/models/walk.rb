class Walk < ApplicationRecord
  include Nextable

  has_many :stations, dependent: :destroy
  belongs_to :user

  validates_presence_of :name, :location, :description

  WALK_BASE_URL = ENV['WALK_APP_URL'] || "https://spaziergang.demokratielabore.de/"

  scope :is_public, -> { where(public: true) }
  scope :public_not_blocked, -> { is_public.reject { |w| w.user.blocked? } }

  def editable_by?(current_user)
    (current_user) && (user == current_user || current_user.admin?)
  end

  def link_in_frontend
    "#{WALK_BASE_URL}/course/#{id}"
  end

  def next_station_priority
    return stations.size
  end

  def every_station_has_subject?
    flag = true
    stations.each do |st|
      flag = false unless st.subjects.present?
    end
    flag
  end

  def every_subject_has_page?
    flag = true
    stations.each do |st|
      flag =  false unless st.subjects.present?
      st.subjects.each do |sub|
        flag = false unless sub.pages.present?
      end
    end
    flag
  end

  def publishable?
    return false unless stations.present? && stations.count >= 2
    return false unless every_station_has_subject?
    return false unless every_subject_has_page?
    return false unless courseline.present?
    true
  end
end
