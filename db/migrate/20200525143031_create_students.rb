class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :student do |t|
      t.string :student_code
      t.string :name
      t.string :dob
      t.string :class_name
      t.string :program
    end
  end
end