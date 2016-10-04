class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user, foreign_key: true, index: true
      t.string :token
      t.string :secret
      t.string :name
      t.string :link

      t.timestamps
    end
    add_index :authorizations, [:provider, :uid]
  end
end
