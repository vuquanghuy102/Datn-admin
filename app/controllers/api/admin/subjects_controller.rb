module Api
  module Admin
    class SubjectsController < BaseController
      PER_PAGE = 50
      before_action :fetch_subject, only: %i[edit update destroy show]

      def index
        sql = Subject.all

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
            render json: @subject
          end
        end
      end

      def create
        form = SubjectValidator.new(OpenStruct.new(subject_params))

        if form.valid?
          @subject = Subject.new(subject_params)
          @subject.subject_code = Subject.last.subject_code[..2] + (Subject.last.subject_code[3..].to_i + 1).to_s
          @subject.save

          render json: @subject, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @subject.destroy
        render json: { message: "Môn học đã bị xóa." }, status: :ok
      rescue StandardError => e
        Rails.logger.error("destroy failed; #{e.message}")
        render json: { message: "Xóa môn học thất bại. Vui lòng thử lại." }, status: :internal_server_error
      end

      def update
        form = SubjectValidator.new(OpenStruct.new(subject_params))

        if form.valid?
          @subject.update(subject_params)
          render json: @subject, status: :ok
        else
          render json: form.error_messages, status: :unprocessable_entity
        end
      end

      def get_list_department_option
        render json: Subject.pluck(:department).uniq
      end

      def get_list_subject_type_option
        render json: Subject.pluck(:subject_type).uniq
      end

      def get_list_name_option
        @list_courses = Subject.all.map do |subject|
          {
            value: subject.id,
            name: subject.subject_name,
          }
        end

        render json: @list_courses
      end

      private

      def fetch_subject
        @subject = Subject.find(params[:id])
      end

      def subject_params
        params.permit(
          :subject_code, :subject_name, :subject_type,
          :credit_value, :jhi_desc, :department, :status, :credit_value_number
        )
      end
    end
  end
end