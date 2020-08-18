module Api
  module Admin
    class SubjectsController < BaseController
      PER_PAGE = 50
      skip_before_action :verify_authenticity_token
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
        form1 = SubjectValidator.new(OpenStruct.new(subject_params))
        form2 = SubjectRequireValidator.new(OpenStruct.new(require_params))
        f1 = form1.valid?
        f2 = form2.valid?

        if f1 && f2
          @subject = Subject.new(subject_params)
          if Subject.last == nil
            @subject.subject_code = "SUBJECT" + "1"
          else
            @subject.subject_code = Subject.last.subject_code[..6] + (Subject.last.subject_code[7..].to_i + 1).to_s
          end
          @subject.save

          if params[:require_pair]
            @subject_pair = Cassandra::RequirePair.new(
              subjectcode: @subject.subject_code,
              requirecode: params[:require_pair]
            )
            @subject_pair.save
          end
          if params[:subject_required]
            @subject_required = Cassandra::SubjectRequire.new(
              subjectcode: @subject.subject_code,
              requirecode: params[:subject_required]
            )
            @subject_required.save
          end

          render json: @subject, status: :ok
        else
          form = form1.error_messages.merge(form2.error_messages)
          render json: form, status: :unprocessable_entity
        end
      end

      def destroy
        @require_pair = Cassandra::RequirePair.where(subjectcode: @subject.subject_code).first
        if @require_pair != nil
          @require_pair.destroy
        end
        @subject_required = Cassandra::SubjectRequire.where(subjectcode: @subject.subject_code).first
        if @subject_required != nil
          @subject_required.destroy
        end

        @subject.destroy
        render json: { message: "Môn học đã bị xóa." }, status: :ok
      rescue StandardError => e
        Rails.logger.error("destroy failed; #{e.message}")
        render json: { message: "Xóa môn học thất bại. Vui lòng thử lại." }, status: :internal_server_error
      end

      def update
        form1 = SubjectValidator.new(OpenStruct.new(subject_params))
        form2 = SubjectRequireValidator.new(OpenStruct.new(require_params))
        f1 = form1.valid?
        f2 = form2.valid?

        if f1 && f2
          @require_pair = Cassandra::RequirePair.where(subjectcode: @subject.subject_code).first
          @subject_required = Cassandra::SubjectRequire.where(subjectcode: @subject.subject_code).first

          if params[:require_pair]
            if @require_pair != nil
              @require_pair.requirecode = params[:require_pair]

              @require_pair.save
            else
              @require_pair = Cassandra::RequirePair.new(
                subjectcode: @subject.subject_code,
                requirecode: params[:require_pair]
              )

              @require_pair.save
            end
          end
          if params[:require_pair] == nil && @require_pair != nil
            @require_pair.requirecode = nil

            @require_pair.save
          end

          if params[:subject_required]
            if @subject_required != nil
              @subject_required.requirecode = params[:subject_required]

              @subject_required.save
            else
              @subject_required = Cassandra::SubjectRequire.new(
                subjectcode: @subject.subject_code,
                requirecode: params[:subject_required]
              )

              @subject_required.save
            end
          end
          if params[:subject_required] == nil && @subject_required != nil
            @subject_required.requirecode = nil

            @subject_required.save
          end

          @subject.update(subject_params)
          render json: @subject, status: :ok
        else
          form = form1.error_messages.merge(form2.error_messages)
          render json: form, status: :unprocessable_entity
        end
      end

      def get_list_department_option
        render json: Subject.pluck(:department).uniq
      end

      def get_list_subject_type_option
        render json: Subject.pluck(:subject_type).uniq
      end

      def get_list_name_code_option
        @list_subjects = Subject.all.map do |subject|
          {
            code: subject.subject_code,
            name: subject.subject_name,
          }
        end

        render json: @list_subjects
      end

      def get_list_name_option
        @list_subjects = Subject.all.map do |subject|
          {
            value: subject.id,
            name: subject.subject_name,
          }
        end

        render json: @list_subjects
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

      def require_params
        params.permit(
          :require_pair, :subject_required
        )
      end
    end
  end
end