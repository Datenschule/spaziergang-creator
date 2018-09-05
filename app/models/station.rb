class Station < ApplicationRecord
  has_many :subjects, dependent: :destroy
  belongs_to :walk
  belongs_to :user

  validates_presence_of :name, :description, :lat, :lon

  def coord
    [lat, lon].join(",")
  end

  def editable_by?(current_user)
    station_access?(current_user)
  end

  def deletable_by?(current_user)
    station_access?(current_user)
  end

  def station_access?(current_user)
    return false unless current_user
    return true if current_user.id == user_id
    return true if current_user.admin?
  end
end
