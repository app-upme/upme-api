class CreateVo2maxTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :vo2max_trainings do |t|
      t.datetime :training_date
      t.float :distance
      t.float :average_speed
      t.float :result
      t.string :ranking

      t.timestamps
    end
  end
end
