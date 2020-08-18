class FpUser < ApplicationRecord
  self.table_name = "FP_USER"
  self.sequence_name = "FP_USER_SEQ"

  has_one :student
end
