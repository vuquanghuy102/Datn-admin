class UsersController < BaseController
  include Pagy::Backend
  before_action :authorization

  private

  def authorization
    authorize User
  end

  def set_title
    @title = "Tài khoản hệ thống"
  end
end
