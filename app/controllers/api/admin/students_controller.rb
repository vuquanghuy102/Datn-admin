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
        form1 = StudentValidator.new(OpenStruct.new(student_params))
        form2 = FpUserValidator.new(OpenStruct.new(fp_user_params))
        f1 = form1.valid?
        f2 = form2.valid?(:create)

        if f1 && f2
          @student = Student.new(student_params)
          if Subject.last == nil
            @student.student_code = "STUDENT" + "1"
          else
            @student.student_code = Student.last.student_code[..6] + (Student.last.student_code[7..].to_i + 1).to_s
          end
          @student.name = fp_user_params[:first_name] + " " + fp_user_params[:last_name]
          @student.save

          u = User.new(password: fp_user_params[:password])

          fp_user = FpUser.new(
            login: @student.student_code,
            first_name: fp_user_params[:first_name],
            last_name: fp_user_params[:last_name],
            password_hash: u.encrypted_password,
            student_id: Student.find_by(student_code: @student.student_code).id,
            email: fp_user_params[:email],
            activated: true
          )

          fp_user.save

          render json: @student, status: :ok
        else
          form = form1.error_messages.merge(form2.error_messages)
          render json: form, status: :unprocessable_entity
        end
      end

      def update
        form1 = StudentValidator.new(OpenStruct.new(student_params))
        form2 = FpUserValidator.new(OpenStruct.new(fp_user_params))
        f1 = form1.valid?
        f2 = form2.valid?(:update)

        if f1 && f2
          @student.update(student_params)
          @student.fp_user.update(
            first_name: fp_user_params[:first_name],
            last_name: fp_user_params[:last_name],
            email: fp_user_params[:email],
          )
          render json: @student, status: :ok
        else
          form = form1.error_messages.merge(form2.error_messages)
          render json: form, status: :unprocessable_entity
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
          :student_code, :dob,
          :class_name, :program
        )
      end

      def fp_user_params
        params.require(:fp_user).permit(
          :id, :first_name, :last_name,
          :email, :password, :password_confirmation
        )
      end
    end
  end
end