class Page < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  validates_presence_of :name, :type
end
