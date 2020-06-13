module SubjectHelper
  def subject_index
    inner_options = {}

    content_tag("subjects-index", nil, inner_options, false)
  end

  def subjects_new_page(subject)
    inner_options = {}

    content_tag('subjects-new-page', nil, inner_options, false)
  end

  def subjects_edit_page(subject)
    inner_options = {
      ":subject-id": params[:id]
    }

    content_tag('subjects-edit-page', nil, inner_options, false)
  end
end
