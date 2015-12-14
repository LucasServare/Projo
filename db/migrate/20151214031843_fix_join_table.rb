class FixJoinTable < ActiveRecord::Migration
  def up
    drop_table :projects_users
    create_table :projects_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
    end
  end

  def down
    drop_table :projects_users
    create_table :projects_users, :id => false do |t|
      t.integer "user_id"
      t.integer "project_id"
    end
  end
end
