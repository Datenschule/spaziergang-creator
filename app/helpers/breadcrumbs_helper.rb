# frozen_string_literal: true

module BreadcrumbsHelper
  def breadcrumb_walk_helper(obj)
    add_breadcrumb "<i data-feather='map' class='va-middle mr-1'></i>
                   #{obj.name}".html_safe, walk_path(obj)
  end

  def breadcrumb_station_helper(obj)
    add_breadcrumb "<i data-feather='map-pin' class='va-middle mr-1'></i>
                   #{obj.name}".html_safe, station_path(obj)
  end

  def breadcrumb_subject_helper(obj)
    add_breadcrumb "<i data-feather='message-circle' class='va-middle mr-1'></i>
                   #{obj.name}".html_safe, subject_path(obj)
  end

  def breadcrumb_page_helper(obj)
    add_breadcrumb "<i data-feather='file-text' class='va-middle mr-1'></i>
                   #{obj.name}".html_safe, page_path(obj)
  end
end
