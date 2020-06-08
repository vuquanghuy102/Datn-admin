class UsersController < BaseController
  include Pagy::Backend
  before_action :authorization

  def index; end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def edit; end

  def authorization
    authorize User
  end
end
