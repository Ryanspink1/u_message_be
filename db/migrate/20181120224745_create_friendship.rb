class CreateFriendship < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.integer :approved, default: 0

      t.timestamps null: false
    end
  end
end
