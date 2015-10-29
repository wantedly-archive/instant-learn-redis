class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations, id: false do |t|
      t.integer :user_id
      t.integer :friend_id
    end
  end
end
