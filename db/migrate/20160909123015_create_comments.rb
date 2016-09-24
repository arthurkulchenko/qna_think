class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :comments_parent, polimorphic: true, index: true, comment: "polimorphic"
      t.string :comments_parent_type, index: true
      t.text :content, comment: 'body of comment'

      t.timestamps
    end
  end
end
