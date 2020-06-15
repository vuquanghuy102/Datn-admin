module ScheduleHelper
  def schedule_index
    inner_options = {}

    content_tag("schedules-index", nil, inner_options, false)
  end

  def schedules_new_page
    inner_options = {}

    content_tag('schedules-new-page', nil, inner_options, false)
  end

  def schedules_edit_page
    inner_options = {
      ":schedule-id": params[:id],
    }

    content_tag('schedules-edit-page', nil, inner_options, false)
  end
end
