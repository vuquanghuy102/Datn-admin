class StudentsController < BaseController
  include Pagy::Backend
  before_action :authorization

  private

  def authorization
    authorize Student
  end

  def set_title
    @title = "Quản lý sinh viên"
  end
end