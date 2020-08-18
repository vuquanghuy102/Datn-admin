module Cassandra
  class UserByEmail
    include Cequel::Record
    self.table_name = :user_by_email

    key :id, :text
    key :email, :text
  end
end