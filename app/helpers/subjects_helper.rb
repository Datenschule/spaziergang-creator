# coding: utf-8
module SubjectsHelper
  def can_edit_subject?(sub)
    has_subject_access(sub)
  end

  def can_delete_subject?(sub)
    has_subject_access(sub)
  end

  def has_subject_access(sub)
    return false unless current_user
    return false unless sub
    return true if current_user.id == sub.user_id
  end
end
