class StudentValidator
  include ActiveModel::Model

  attr_accessor :dob,
                :class_name, :program

  validates :dob,
            :class_name, :program, presence: true
  validate :check_undefined

  def initialize(attributes = {})
    @dob = attributes.dob
    @class_name = attributes.class_name
    @program = attributes.program
  end

  def error_messages
    errors.to_hash(true)
  end

  def check_undefined
    if @dob == "undefined"
      errors.add(:dob, :blank)
    end
    if @class_name == "undefined"
      errors.add(:class_name, :blank)
    end
    if @program == "undefined"
      errors.add(:program, :blank)
    end
  end
end
