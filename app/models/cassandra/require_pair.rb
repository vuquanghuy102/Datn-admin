module Cassandra
  class RequirePair
    include Cequel::Record
    self.table_name = :requirepair

    key :id, :uuid, auto: true
    column :subjectcode, :text, index: true
    column :requirecode, :text, index: true
  end
end