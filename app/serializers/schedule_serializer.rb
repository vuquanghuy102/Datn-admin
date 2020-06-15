class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :week_value, :week_day_value, :period_value, :location,
             :course_id, :course

  belongs_to :course
end
