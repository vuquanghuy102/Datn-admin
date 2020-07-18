module Cassandra
  class SubjectRequire
    include Cequel::Record
    self.table_name = :subjectrequire

    key :id, :uuid, auto: true
    column :subjectcode, :text, index: true
    column :requirecode, :text, index: true
  end
end