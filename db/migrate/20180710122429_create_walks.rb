class CreateWalks < ActiveRecord::Migration[5.2]
  def change
    create_table :walks do |t|
      t.string :name, null: false, default: ''
      t.string :location, null: false, default: ''
      t.string :preview_image, null: false, default: ''
      t.string :description, null: false, default: ''
      t.integer :entry, null: false, default: 0
      t.string :courseline, null: false, default: '[]'
      t.timestamps
    end
  end
end
