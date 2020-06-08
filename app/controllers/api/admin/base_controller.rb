module Api
  module Admin
    class BaseController < ActionController::Base
      include Pagy::Backend
    end
  end
end