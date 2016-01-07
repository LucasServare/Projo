class CreateToDoItems < ActiveRecord::Migration
  def change
    create_table :to_do_items do |t|
      t.string "content", :limit => 100
      t.boolean "completed", :default => false
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
