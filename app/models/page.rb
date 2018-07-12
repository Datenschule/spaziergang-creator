class Page < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :subject
  belongs_to :user

  TYPES = [:story, :iframe, :quiz]

  validates_presence_of :name, :type
  validates :type, inclusion: TYPES.map { |k| k.to_s }
  validates :link, website: true, allow_blank: true
end
