class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :role do |t|
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
