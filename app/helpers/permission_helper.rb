module PermissionHelper
  def permission_index
    inner_options = {}

    content_tag("permissions-index", nil, inner_options, false)
  end
end
