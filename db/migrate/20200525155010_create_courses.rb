class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_code
      t.integer :max_slot
      t.integer :status
      t.integer :current_slot
      t.references :subject
    end
  end
end