class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.integer :entry, null: false, default: 0
      t.integer :station_id
      t.timestamps
    end
  end
end
