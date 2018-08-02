module WalksHelper
  def can_edit_walk?(walk)
    current_user && walk && walk.user == current_user
  end
end
