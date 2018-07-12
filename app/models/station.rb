class Station < ApplicationRecord
  has_many :subjects
  belongs_to :walk
  belongs_to :user

  validates_presence_of :name, :description, :lat, :lon

  def coord
    [lat, lon]
  end
end
