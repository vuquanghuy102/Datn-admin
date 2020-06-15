module Api
  module Admin
    class StudentsController < BaseController
      PER_PAGE = 50
      before_action :fetch_student, only: %i[edit update destroy show]

      def index
        sql = Student.all

        collection = sql.ransack(params[:q]).result(distinct: true).order(id: :desc)

        pagy, students = pagy(
          collection,
          items: PER_PAGE,
          page: params[:page]
        )

        render json: students, adapter: :json,
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
            @student.dob = @student.dob.to_date
            render json: @student
          end
        end
      end

      def create
        form = StudentValidator.new(OpenStruct.new(student_params))

        if form.valid?
          @student = Student.new(student_params)
          @student.student_code = Student.last.student_code[..3] + (Student.last.student_code[4..].to_i + 1).to_s
          @student.save

          render json: @student, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def update
        form = StudentValidator.new(OpenStruct.new(student_params))

        if form.valid?
          @student.update(student_params)
          render json: @student, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @student.destroy
        render json: { message: "Sinh viên đã bị xóa." }, status: :ok
      rescue StandardError => e
        Rails.logger.error("destroy failed; #{e.message}")
        render json: { message: "Xóa sinh viên thất bại. Vui lòng thử lại." }, status: :internal_server_error
      end

      def get_list_program_option
        render json: Student.pluck(:program).uniq
      end

      def get_list_class_name_option
        render json: Student.pluck(:class_name).uniq
      end

      private

      def fetch_student
        @student = Student.find(params[:id])
      end

      def student_params
        params.permit(
          :student_code, :name, :dob,
          :class_name, :program
        )
      end
    end
  end
end