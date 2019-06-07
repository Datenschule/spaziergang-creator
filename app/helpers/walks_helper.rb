module WalksHelper
  def walks_public_status_helper(walk)
    walk_status = 'walk'
    if walk.stations.present? && walk.stations.count >= 2
      walk_status = 'station'
      if walk.stations.all? { |sta| sta.subjects.present? }
        walk_status = 'subject'
        if walk.stations.sort_by(&:priority).first.subjects.all? { |sub| sub.pages }.present?
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
