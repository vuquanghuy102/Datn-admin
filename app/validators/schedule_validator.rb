class ScheduleValidator
  include ActiveModel::Model

  attr_accessor :week_value, :week_day_value, :period_value,
                :location, :course_id

  validates :week_value, :week_day_value, :period_value,
            :location, :course_id, presence: true
  validates :course_id, numericality: { only_integer: true }
  validate :check_undefined

  def initialize(attributes = {})
    @week_value = attributes.week_value
    @week_day_value = attributes.week_day_value
    @period_value = attributes.period_value
    @location = attributes.location
    @course_id = attributes.course_id
  end

  def error_messages
    errors.to_hash(true)
  end

  def check_undefined
    if @week_value == "undefined"
      errors.add(:week_value, :blank)
    end
    if @week_day_value == "undefined"
      errors.add(:week_day_value, :blank)
    end
    if @period_value == "undefined"
      errors.add(:period_value, :blank)
    end
    if @location == "undefined"
      errors.add(:location, :blank)
    end
    if @course_id == "undefined"
      errors.add(:course_id, :blank)
    end
  end
end
