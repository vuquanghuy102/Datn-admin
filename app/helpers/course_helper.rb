module CourseHelper
  def course_index
    inner_options = {}

    content_tag("courses-index", nil, inner_options, false)
  end

  def courses_new_page
    inner_options = {}

    content_tag('courses-new-page', nil, inner_options, false)
  end

  def courses_edit_page
    inner_options = {
      ":course-id": params[:id],
    }

    content_tag('courses-edit-page', nil, inner_options, false)
  end
end
