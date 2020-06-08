module Api
  module Admin
    class UsersController < BaseController
      PER_PAGE = 50
      before_action :fetch_user, only: %i[edit update destroy show]

      def index
        sql = User.all

        collection = sql.ransack(params[:q]).result(distinct: true).order(id: :desc)

        pagy, users = pagy(
          collection,
          items: PER_PAGE,
          page: params[:page]
        )

        render json: users, adapter: :json,
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
            render json: @user
          end
        end
      end

      def create
        form = UserValidator.new(OpenStruct.new(user_params))

        if form.valid?(:create)
          user = User.create!(user_params)
          render json: user, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def update
        form = UserValidator.new(OpenStruct.new(user_params))

        if form.valid?(:update)
          @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy!

        render json: { message: "Xoá tài khoản thành công." }, status: :ok
      rescue StandardError => e
        render json: { message: "Xóa tài khoản thất bại. Vui lòng thử lại." }, status: :unprocessable_entity
      end

      private

      def fetch_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(
          :id, :email, :password, :name,
          user_roles_attributes: %i[
            id role_id _destroy
          ]
        )
      end
    end
  end
end