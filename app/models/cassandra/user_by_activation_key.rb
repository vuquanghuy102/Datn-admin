module Cassandra
  class UserByActivationKey
    include Cequel::Record
    self.table_name = :user_by_activation_key

    key :id, :text
    key :activation_key, :text
  end
end