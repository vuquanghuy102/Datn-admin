module Api
  module Admin
    class RolesController < BaseController
      PER_PAGE = 50
      before_action :fetch_role, only: %i[edit update destroy show]

      def index
        sql = Role.all

        collection = sql.ransack(params[:q]).result(distinct: true).order(id: :desc)

        pagy, roles = pagy(
          collection,
          items: PER_PAGE,
          page: params[:page]
        )

        render json: roles, adapter: :json,
               meta: {
                 total: pagy.count, page: pagy.page,
                 from: pagy.from, to: pagy.to, series: pagy.series
               }
      rescue Pagy::OverflowError => e
        Rails.logger.error("#{self.class.name} error #{action_name} fetch #{e.backtrace.join('\n')}")
        render json: []
      end

      def show
        respond_to do |format|
          format.html
          format.json do
            render json: @role
          end
        end
      end

      def create
        form = RoleValidator.new(OpenStruct.new(role_params))

        if form.valid?
          role = Role.create!(role_params)
          render json: role, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def update
        form = RoleValidator.new(OpenStruct.new(role_params))

        if form.valid?
          @role.update(role_params)
          render json: @role, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @role.destroy!

        render json: { message: "Chức vụ đã bị xóa." }, status: :ok
      rescue StandardError => e
        render json: { message: "Xóa chức vụ thất bại. Vui lòng thử lại." }, status: :unprocessable_entity
      end

      def list_select
        @list_role = Role.all.map do |role|
          {
            value: role.id,
            name: role.name,
          }
        end

        render json: @list_role
      end

      private

      def fetch_role
        @role = Role.find(params[:id])
      end

      def role_params
        params.require(:role).permit(
          :name, :description
        )
      end
    end
  end
end