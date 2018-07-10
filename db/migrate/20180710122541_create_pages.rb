class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :name, null: false, default: ''
      t.integer :next, null: true
      t.integer :prev, null: true
      t.string :type, null: false, default: ''
      t.integer :subject_id, null: false
      t.timestamps
    end
  end
end
