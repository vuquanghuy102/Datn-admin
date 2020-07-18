class UserRole < ApplicationRecord
  # dùng khi chọc vào db khác
  self.table_name = "USER_ROLE"
  self.sequence_name = "USER_ROLE_SEQ"

  belongs_to :user
  belongs_to :role
end
