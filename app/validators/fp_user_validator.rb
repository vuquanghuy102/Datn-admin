class FpUserValidator
  include ActiveModel::Model

  attr_accessor :id, :first_name, :last_name, :email, :password, :password_confirmation

  validates :first_name, :last_name, presence: true

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :email_uniqueness
  validates :password, presence: true, length: { minimum: 8 }, on: :create, confirmation: true
  validates :password_confirmation, presence: :true, on: :create
  validate :check_undefined

  def initialize(attributes = {})
    @id = attributes.id
    @first_name = attributes.first_name
    @last_name = attributes.last_name
    @email = attributes.email
    @password = attributes.password
    @password_confirmation = attributes.password_confirmation
  end

  def email_uniqueness
    return unless FpUser.where(email: @email).where.not(id: @id).exists?

    errors.add(:email, :was_used)
  end

  def error_messages
    errors.to_hash(true)
  end

  def check_undefined
    if @id == "undefined"
      errors.add(:id, :blank)
    end
    if @first_name == "undefined"
      errors.add(:first_name, :blank)
    end
    if @last_name == "undefined"
      errors.add(:last_name, :blank)
    end
    if @email == "undefined"
      errors.add(:email, :blank)
    end
    if @password == "undefined"
      errors.add(:password, :blank)
    end
    if @password_confirmation == "undefined"
      errors.add(:password_confirmation, :blank)
    end
  end
end
