module Cassandra
  class PassStatus
    include Cequel::Record
    self.table_name = :passstatus

    key :id, :uuid, auto: true
    column :studentid, :text
    column :coursepass, :text
  end
end