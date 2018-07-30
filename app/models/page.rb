class Page < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :subject
  belongs_to :user

  VARIANTS = [:story, :iframe, :quiz]

  validates_presence_of :name, :variant
  validates :variant, inclusion: VARIANTS.map { |k| k.to_s }
  validates :link, website: true, allow_blank: true
end
