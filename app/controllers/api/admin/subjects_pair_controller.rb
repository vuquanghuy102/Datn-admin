module Api
  module Admin
    class SubjectsPairController < BaseController
      def get_list
        get_subject = Subject.find(params[:subject_id])

        render json: Cassandra::RequirePair.where(subjectcode: get_subject.subject_code).allow_filtering!
      end
    end
  end
end