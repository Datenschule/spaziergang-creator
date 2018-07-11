class AddUserToStationSubjectPage < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :user_id, :integer, null: false, default: 0
    add_column :subjects, :user_id, :integer, null: false, default: 0
    add_column :pages, :user_id, :integer, null: false, default: 0
  end
end
