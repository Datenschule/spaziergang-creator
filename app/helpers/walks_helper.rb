module WalksHelper
  def walks_public_status_helper(walk)
    walk_status = 'walk'
    if walk.stations.present? && walk.stations.count >= 2
      walk_status = 'station'
      if walk.every_station_has_subject?
        walk_status = 'subject'
        if walk.every_subject_has_page?
          walk_status = 'page'
          if walk.courseline.present?
            walk_status = 'courseline'
          end
        end
      end
    end
    walk_status
  end
end
