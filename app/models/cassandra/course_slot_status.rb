module Cassandra
  class CourseSlotStatus
    include Cequel::Record
    self.table_name = :courseslotstatus

    key :id, :uuid, auto: true
    column :coursecode, :text
    column :maxslot, :bigint
    column :currentslot, :bigint
  end
end