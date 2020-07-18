module Api
  module Admin
    class CoursesController < BaseController
      PER_PAGE = 50
      before_action :fetch_course, only: %i[edit update destroy show]

      def index
        sql = Course.all

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
            render json: @course
          end
        end
      end

      def create
        form = CourseValidator.new(OpenStruct.new(course_params))

        if form.valid?
          @course = Course.new(course_params)
          if Course.last == nil
            @course.course_code = "COURSE" + "1"
          else
            @course.course_code = Course.last.course_code[..5] + (Course.last.course_code[6..].to_i + 1).to_s
          end
          @course.save

          render json: @course, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def update
        form = CourseValidator.new(OpenStruct.new(course_params))

        if form.valid?
          @course.update(course_params)
          render json: @course, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @course.destroy
        render json: { message: "Học phần đã bị xóa." }, status: :ok
      rescue StandardError => e
        Rails.logger.error("destroy failed; #{e.message}")
        render json: { message: "Xóa học phần thất bại. Vui lòng thử lại." }, status: :internal_server_error
      end

      def get_list_courses_status_option
        render json: Course.select_status_i18n.to_json
      end

      def get_list_courses_code_option
        @list = Course.all.map do |course|
          {
            value: course.id,
            code: course.course_code,
          }
        end

        render json: @list
      end

      private

      def fetch_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.permit(
          :course_code, :max_slot, :status,
          :subject_id, :current_slot
        )
      end
    end
  end
end