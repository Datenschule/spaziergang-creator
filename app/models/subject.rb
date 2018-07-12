class Subject < ApplicationRecord
  has_many :pages
  belongs_to :station
  belongs_to :user

  validates_presence_of :name, :description
end
