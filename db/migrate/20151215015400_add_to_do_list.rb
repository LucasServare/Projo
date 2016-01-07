class AddToDoList < ActiveRecord::Migration
  def change
    create_table(:to_do) do |t|
      t.string :content, limit:100
      t.belongs_to :user, index:true
      t.boolean :completed, default => false
      t.timestamps null: false
    end
  end
end
