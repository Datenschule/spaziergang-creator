module WalksHelper
  def walks_public_status_helper
    walk_status = 'walk'
    if @walk.stations.present? && @walk.stations.count >= 2
      walk_status = 'station'
      if @walk.courseline.present?
        walk_status = 'courseline'
        if @walk.stations.first.subjects.present?
          walk_status = 'subject'
          if @walk.stations.first.subjects.first.pages.present?
            walk_status = 'page'
          end
        end
      end
    end
    walk_status
  end
end
