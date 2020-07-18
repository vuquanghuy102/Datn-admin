module Cassandra
  class ActivationKeyByCreationDate
    include Cequel::Record
    self.table_name = :activation_key_by_creation_date

    key :creation_date, :timeuuid, auto: true
    key :activation_key, :text
  end
end