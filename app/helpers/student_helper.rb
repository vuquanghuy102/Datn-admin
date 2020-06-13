module StudentHelper
  def student_index
    inner_options = {}

    content_tag("students-index", nil, inner_options, false)
  end

  def students_new_page(student)
    inner_options = {}

    content_tag('students-new-page', nil, inner_options, false)
  end

  def students_edit_page(student)
    inner_options = {
      ":student-id": params[:id],
    }

    content_tag('students-edit-page', nil, inner_options, false)
  end
end
