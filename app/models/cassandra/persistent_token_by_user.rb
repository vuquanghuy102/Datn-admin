module Cassandra
  class PersistentTokenByUser
    include Cequel::Record
    self.table_name = :persistent_token_by_user

    key :user_id, :text
    key :persistent_token_series, :text
  end
end