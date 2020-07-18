class StudentValidator
  include ActiveModel::Model

  attr_accessor :dob,
                :class_name, :program

  validates :dob,
            :class_name, :program, presence: true

  def initialize(attributes = {})
    @dob = attributes.dob
    @class_name = attributes.class_name
    @program = attributes.program
  end

  def error_messages
    errors.to_hash(true)
  end
end
