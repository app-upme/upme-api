class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :group, foreign_key: true
      t.string :name
      t.string :email
      t.string :avatar
      t.integer :age
      t.string :gender
      t.datetime :started_training_at

      t.timestamps
    end
  end
end
