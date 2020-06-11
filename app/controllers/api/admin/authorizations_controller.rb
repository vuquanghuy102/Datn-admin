module Api
  module Admin
    class AuthorizationsController < BaseController
      def get_list
        @list_author = Authorization.where.not(id: 9999).group_by(&:target_name).map do |item|
          {
            target_name: item[0],
            authorizations: item[1].map do |authorization|
              {
                id: authorization.id,
                target_name: authorization.target,
                action: authorization.action,
                name: authorization.name,
              }
            end,
          }
        end

        render json: @list_author
      end
    end
  end
end