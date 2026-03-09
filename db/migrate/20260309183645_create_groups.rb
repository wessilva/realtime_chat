class CreateGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps

      t.references :admin, foreign_key: { to_table: :users}
    end
  end
end
