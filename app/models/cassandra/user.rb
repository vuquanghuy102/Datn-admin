module Cassandra
  class User
    include Cequel::Record
    self.table_name = :user

    key :id, :text
    column :login, :text
    column :password, :text
    column :firstname, :text
    column :lastname, :text
    column :email, :text
    column :activated, :boolean
    column :lang_key, :text
    column :activation_key, :text
    column :reset_key, :text
    column :reset_date, :timestamp
    column :authorities, :text
  end
end