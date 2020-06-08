module Api
  module Admin
    class RolesController < BaseController
      PER_PAGE = 50

      def list_select
        @list_role = Role.all.map do |role|
          {
            value: role.id,
            name: role.name,
          }
        end

        render json: @list_role
      end
    end
  end
end