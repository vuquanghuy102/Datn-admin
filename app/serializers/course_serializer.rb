class CourseSerializer < ActiveModel::Serializer
  attributes :id, :course_code, :max_slot, :status_i18n, :status, :subject_id, :current_slot,
             :subject

  belongs_to :subject
end
