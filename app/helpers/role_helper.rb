module RoleHelper
  def role_index
    content_tag("roles-index", nil, nil, false)
  end

  def roles_new_page
    inner_options = {}

    content_tag('roles-new-page', nil, inner_options, false)
  end

  def roles_edit_page
    inner_options = {
      'role-id': params[:id]
    }

    content_tag('roles-edit-page', nil, inner_options, false)
  end
end
