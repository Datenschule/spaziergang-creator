class NotNullPagePriority < ActiveRecord::Migration[5.2]
  def change
    Page.where(priority: nil).update_all(priority: 0)
    change_column_null(:pages, :priority, :integer, 0)
  end
end
