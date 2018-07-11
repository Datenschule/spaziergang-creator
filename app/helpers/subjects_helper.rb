module SubjectsHelper
  def can_edit_subject(sub)
    if current_user && sub
      link_to(edit_subject_path(sub), class: "btn tooltip", data: { tooltip: "bearbeiten"}) do
        '<i data-feather="edit-3"></i>'.html_safe
      end
    end
  end
end
