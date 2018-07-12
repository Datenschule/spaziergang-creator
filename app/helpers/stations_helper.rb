module StationsHelper
  def can_edit_station?(st)
    has_station_access(st)
  end

  def can_delete_station?(st)
    has_station_access(st)
  end

  def has_station_access(st)
    return false unless current_user
    return false unless st
    return true if current_user.id == st.user_id
  end
end
