class AddConfirmedemailToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_confirmed, :boolean, default: false
  end
end
