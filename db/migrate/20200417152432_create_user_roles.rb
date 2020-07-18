class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_role do |t|
      t.references :user
      t.references :role

      t.timestamps
    end
  end
end
