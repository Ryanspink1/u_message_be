class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :recipient, index: true
      t.timestamps null: false
    end
  end
end
