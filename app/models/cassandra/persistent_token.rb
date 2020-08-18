module Cassandra
  class PersistentToken
    include Cequel::Record
    self.table_name = :persistent_token

    key :series, :text
    column :token_date, :timestamp
    column :user_agent, :text
    column :token_value, :text
    column :login, :text
    column :user_id, :text
    column :ip_address, :text
  end
end