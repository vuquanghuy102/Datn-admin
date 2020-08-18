module Cassandra
  class UserByResetKey
    include Cequel::Record
    self.table_name = :user_by_reset_key

    key :id, :text
    key :reset_key, :text
  end
end