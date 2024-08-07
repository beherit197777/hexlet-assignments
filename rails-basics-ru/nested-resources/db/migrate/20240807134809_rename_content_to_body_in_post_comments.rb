class RenameContentToBodyInPostComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :post_comments, :content, :body
    add_column :post_comments, :name, :string
  end
end
