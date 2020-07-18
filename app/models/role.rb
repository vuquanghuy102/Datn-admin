class Role < ApplicationRecord
  # dùng khi chọc vào db khác
  self.table_name = "ROLE"
  self.sequence_name = "ROLE_SEQ"

  has_many :user_roles
  has_many :permissions
end
