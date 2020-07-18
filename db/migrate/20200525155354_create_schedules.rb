class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedule do |t|
      t.string :week_value
      t.string :week_day_value
      t.string :period_value
      t.string :location
      t.references :course
    end
  end
end
