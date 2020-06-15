class PermissionsController < BaseController
  before_action :authorization

  private

  def authorization
    authorize Permission
  end

  def set_title
    @title = "Ủy quyền"
  end
end