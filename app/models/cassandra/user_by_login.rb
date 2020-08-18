module Cassandra
  class UserByLogin
    include Cequel::Record
    self.table_name = :user_by_login

    key :id, :text
    key :login, :text
  end
end