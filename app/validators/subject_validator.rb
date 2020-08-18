class SubjectValidator
  include ActiveModel::Model

  attr_accessor :subject_name, :subject_type,
                :credit_value, :jhi_desc, :department, :status, :credit_value_number

  validates :credit_value_number, numericality: { only_integer: true }, allow_blank: true
  validates :subject_name, :subject_type, :credit_value,
            :jhi_desc, :department, :status, presence: true
  validate :check_undefined

  def initialize(attributes = {})
    @subject_name = attributes.subject_name
    @subject_type = attributes.subject_type
    @credit_value = attributes.credit_value
    @jhi_desc = attributes.jhi_desc
    @department = attributes.department
    @status = attributes.status
    @credit_value_number = attributes.credit_value_number
  end

  def error_messages
    errors.to_hash(true)
  end

  def check_undefined
    if @subject_name == "undefined"
      errors.add(:subject_name, :blank)
    end
    if @subject_type == "undefined"
      errors.add(:subject_type, :blank)
    end
    if @credit_value == "undefined"
      errors.add(:credit_value, :blank)
    end
    if @jhi_desc == "undefined"
      errors.add(:jhi_desc, :blank)
    end
    if @department == "undefined"
      errors.add(:department, :blank)
    end
    if @status == "undefined"
      errors.add(:status, :blank)
    end
    if @credit_value_number == "undefined"
      errors.add(:credit_value_number, :blank)
    end
  end
end
