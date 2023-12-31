class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.text :workout
      t.integer :duration_in_min
      t.date :workout_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
