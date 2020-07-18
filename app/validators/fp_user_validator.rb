class FpUserValidator
  include ActiveModel::Model

  attr_accessor :id, :first_name, :last_name, :email, :password, :password_confirmation

  validates :first_name, :last_name, presence: true

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :email_uniqueness
  validates :password, presence: true, length: { minimum: 8 }, on: :create, confirmation: true
  validates :password_confirmation, presence: :true, on: :create

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
end
