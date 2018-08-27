class ChangePagesPriorityDefault < ActiveRecord::Migration[5.2]
  def up
    change_column_default(:pages, :priority, -1)
  end
  def down
    change_column_default(:pages, :priority, nil)
  end
end
