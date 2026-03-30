class AddUniqueIndexToConversants < ActiveRecord::Migration[8.1]
  def change
    add_index :conversants, [:user_id, :room_id], unique: true
  end
end
