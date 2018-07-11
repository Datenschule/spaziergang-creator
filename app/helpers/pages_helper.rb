module PagesHelper
  def can_edit_station(st)
    if current_user && st && st.walk.user == current_user
      link_to(edit_station_path(st), class: "btn tooltip", data: { tooltip: "bearbeiten"}) do
        '<i data-feather="edit-3"></i>'.html_safe
      end
    end
  end
end
