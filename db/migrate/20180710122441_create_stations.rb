class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.float :lat, null: false, default: 0.0
      t.float :lon, null: false, default: 0.0
      t.integer :next, null: true
      t.string :line, null: false, default: '[]'
      t.integer :walk_id, null: false
      t.timestamps
    end
  end
end
