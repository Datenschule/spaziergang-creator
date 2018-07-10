module WalksHelper
  def can_edit_walk(walk)
    if current_user && walk && walk.user == current_user
      link_to "edit", edit_walk_path(walk), class: "btn tooltip", data: { tooltip: "bearbeiten"}
    end
  end
end
