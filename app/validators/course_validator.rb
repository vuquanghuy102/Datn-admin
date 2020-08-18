class CourseValidator
  include ActiveModel::Model

  attr_accessor :max_slot, :subject_id, :status

  validates :max_slot, :subject_id, numericality: { only_integer: true }
  validates :max_slot, :status, :subject_id, presence: true
  validate :check_undefined

  def initialize(attributes = {})
    @max_slot = attributes.max_slot
    @status = attributes.status
    @subject_id = attributes.subject_id
  end

  def error_messages
    errors.to_hash(true)
  end

  def check_undefined
    if @max_slot == "undefined"
      errors.add(:max_slot, :blank)
    end
    if @status == "undefined"
      errors.add(:status, :blank)
    end
    if @subject_id == "undefined"
      errors.add(:subject_id, :blank)
    end
  end
end
