class Page < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :subject
  belongs_to :user

  VARIANTS = [:story, :iframe, :quiz]

  validates_presence_of :name, :variant
  validates :variant, inclusion: VARIANTS.map { |k| k.to_s }
  validates :link, website: true, allow_blank: true

  def editable_by?(current_user)
    page_access?(current_user)
  end

  def deletable_by?(current_user)
    page_access?(current_user)
  end

  def page_access?(current_user)
    return false unless current_user
    return true if current_user.id == user_id
  end
end
