class CreateFpUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :fp_user do |t|
      t.string :login
      t.string :password_hash
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image_url
      t.integer :activated
      t.string :lang_key
      t.string :activation_key
      t.string :reset_key
      t.string :created_by
      t.datetime :created_date
      t.datetime :reset_date
      t.string :last_modified_by
      t.datetime :last_modified_date

      t.references :student
    end
  end
end
