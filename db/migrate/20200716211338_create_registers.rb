class CreateRegisters < ActiveRecord::Migration[6.0]
  def change
    create_table :register do |t|
      t.string :semester
      t.string :status

      t.references :student
      t.references :course
    end
  end
end
