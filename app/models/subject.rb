class Subject < ApplicationRecord
  has_many :pages, dependent: :destroy
  belongs_to :station
  belongs_to :user

  validates_presence_of :name, :description

  def editable_by?(current_user)
    subject_access?(current_user)
  end

  def deletable_by?(current_user)
    subject_access?(current_user)
  end

  def subject_access?(current_user)
    return false unless current_user
    return true if current_user.id == user_id
    return true if current_user.admin?
  end
end
