class SchedulesController < BaseController
  include Pagy::Backend
  before_action :authorization

  private

  def authorization
    authorize Schedule
  end

  def set_title
    @title = "Quản lý lịch học của học phần"
  end
end