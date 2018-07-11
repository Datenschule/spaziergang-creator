class Walk < ApplicationRecord
  has_many :stations, dependent: :destroy
  belongs_to :user

  validates_presence_of :name, :location, :description

  scope :is_public, -> { where(public: true) }
end
