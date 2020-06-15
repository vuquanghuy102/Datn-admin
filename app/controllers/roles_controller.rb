class RolesController < BaseController
  include Pagy::Backend
  before_action :authorization

  private

  def authorization
    authorize Role
  end

  def set_title
    @title = "Quản lý chức vụ"
  end
end