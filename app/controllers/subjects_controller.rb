class SubjectsController < BaseController
  include Pagy::Backend
  before_action :authorization

  private

  def authorization
    authorize Subject
  end

  def set_title
    @title = "Quản lý môn học"
  end
end