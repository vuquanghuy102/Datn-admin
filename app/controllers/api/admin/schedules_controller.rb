module Api
  module Admin
    class SchedulesController < BaseController
      PER_PAGE = 50
      before_action :fetch_schedule, only: %i[edit update destroy show]

      def index
        sql = Schedule.all

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
            render json: @schedule
          end
        end
      end

      def create
        form = ScheduleValidator.new(OpenStruct.new(schedule_params))

        if form.valid?
          @schedule = Schedule.new(schedule_params)
          @schedule.save

          render json: @schedule, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def update
        form = ScheduleValidator.new(OpenStruct.new(schedule_params))

        if form.valid?
          @schedule.update(schedule_params)
          render json: @schedule, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @schedule.destroy
        render json: { message: "Lịch học đã bị xóa." }, status: :ok
      rescue StandardError => e
        Rails.logger.error("destroy failed; #{e.message}")
        render json: { message: "Xóa lịch học thất bại. Vui lòng thử lại." }, status: :internal_server_error
      end

      private

      def fetch_schedule
        @schedule = Schedule.find(params[:id])
      end

      def schedule_params
        params.permit(
          :week_value, :week_day_value, :period_value,
          :location, :course_id
        )
      end
    end
  end
end