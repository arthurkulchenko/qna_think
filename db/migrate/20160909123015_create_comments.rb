class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :parent, polimorphic: true, comment: "polimorphic"
      t.string :parent_type
      t.text :content, comment: 'body of comment'

      t.timestamps
    end
    add_index :comments, [:parent_id, :parent_type]
  end
end
