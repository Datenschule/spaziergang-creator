class Subject < ApplicationRecord
  has_many :pages, dependent: :destroy
  belongs_to :station

  validates_presence_of :name, :description
end
