class SubjectRequireValidator
  include ActiveModel::Model

  attr_accessor :require_pair, :subject_required

  validate :check_subject_required_and_pair_uniq

  def initialize(attributes = {})
    @require_pair = attributes.require_pair
    @subject_required = attributes.subject_required
  end

  def error_messages
    errors.to_hash(true)
  end

  def check_subject_required_and_pair_uniq
    if @require_pair == @subject_required && @require_pair != nil
      errors.add(:require_pair, :duplicate_require_pair)
      errors.add(:subject_required, :duplicate_subject_required)
    end
  end
end
