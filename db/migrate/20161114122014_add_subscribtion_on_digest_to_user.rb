class AddSubscribtionOnDigestToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscibe_on_digest, :boolean, default: false
  end
end
