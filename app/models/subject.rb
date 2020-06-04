class Subject < ApplicationRecord
  has_many :course

  enum status: {
    active: 1,
    archived: 0,
  }
end