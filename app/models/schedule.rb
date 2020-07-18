class Schedule < ApplicationRecord
  self.table_name = "SCHEDULE"
  self.sequence_name = "SCHEDULE_SEQ"

  belongs_to :course
end