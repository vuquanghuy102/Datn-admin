class Subject < ApplicationRecord
  self.table_name = "SUBJECT"
  self.sequence_name = "SUBJECT_SEQ"

  has_many :course

  enum status: {
    active: 1,
    archived: 0,
  }
end