module Cassandra
  class StudentRegisterStatus
    include Cequel::Record
    self.table_name = :studentregisterstatus

    key :id, :uuid, auto: true
    column :studentid, :text
    column :isprior, :bigint
    column :maxregister, :bigint
    column :currentregister, :bigint
  end
end