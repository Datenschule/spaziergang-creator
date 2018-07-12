class AddPagesExtraFields < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :content, :string
    add_column :pages, :challenges, :string
    add_column :pages, :link, :string
    add_column :pages, :question, :string
    add_column :pages, :answers, :string
    add_column :pages, :correct, :integer
  end
end
