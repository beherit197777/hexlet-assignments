class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name, limit: 255, null: false
      t.text :description
      t.string :status, limit: 20, null: false, default: "new"
      t.string :creator, limit: 255, null: false
      t.string :performer, limit: 255
      t.boolean :completed, null: false

      t.timestamps
    end
  end
end
