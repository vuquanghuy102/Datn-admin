class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :user do |t|
      t.string :name

      t.timestamps
    end
  end
end
