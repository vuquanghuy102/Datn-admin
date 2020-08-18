class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permission do |t|
      t.references :role, null: false
      t.integer :authorization_id, null: false

      t.timestamps
    end
    add_index :permission, %i[role_id authorization_id], unique: true
  end
end
