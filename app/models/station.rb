class Station < ApplicationRecord
  has_many :subjects, dependent: :destroy
  belongs_to :walk

  validates_presence_of :name, :description, :lat, :lon

  def coord
    [lat, lon]
  end
end
