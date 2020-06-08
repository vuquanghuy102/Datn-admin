module UserHelper
  def user_index
    inner_options = {}

    content_tag("users-index", nil, inner_options, false)
  end

  def users_new_page
    inner_options = {}

    content_tag('users-new-page', nil, inner_options, false)
  end

  def users_edit_page
    inner_options = {
      'user-id': params[:id]
    }
    content_tag('users-edit-page', nil, inner_options, false)
  end
end
