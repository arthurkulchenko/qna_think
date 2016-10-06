class AddConfirmedemailToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_real, :boolean, default: true
  end
end
