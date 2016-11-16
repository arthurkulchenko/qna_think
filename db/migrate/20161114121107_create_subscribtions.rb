class CreateSubscribtions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribtions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :subscribtable, polymorphic: true

      t.timestamps
    end
    add_index :subscribtions, [:user_id, :subscribtable_id]
  end
end
