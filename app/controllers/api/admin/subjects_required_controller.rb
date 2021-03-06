module Api
  module Admin
    class SubjectsRequiredController < BaseController
      def get_list
        get_subject = Subject.find(params[:subject_id])

        render json: Cassandra::SubjectRequire.where(subjectcode: get_subject.subject_code).first
      end
    end
  end
end