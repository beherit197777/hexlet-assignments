class CreatePostComments < ActiveRecord::Migration[7.1]
  def change
    create_table :post_comments do |t|
      t.text :content
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
