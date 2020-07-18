class StudentSerializer < ActiveModel::Serializer
  attributes :id, :student_code, :name, :dob, :class_name,
             :program, :fp_user

  has_one :fp_user
end
