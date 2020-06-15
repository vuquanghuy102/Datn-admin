class CoursesController < BaseController
  include Pagy::Backend
  before_action :authorization

  private

  def authorization
    authorize Course
  end

  def set_title
    @title = "Quản lý học phần"
  end
end