class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subject do |t|
      t.string :subject_code
      t.string :subject_name
      t.string :subject_type
      t.string :credit_value
      t.string :jhi_desc
      t.string :department
      t.integer :status
      t.integer :credit_value_number
    end
  end
end