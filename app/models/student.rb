class Student < ApplicationRecord
  self.table_name = "STUDENT"
  self.sequence_name = "STUDENT_SEQ"

  has_one :fp_user
end