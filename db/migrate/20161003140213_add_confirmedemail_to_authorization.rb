class AddConfirmedemailToAuthorization < ActiveRecord::Migration[5.0]
  def change
    add_column :authorizations, :is_confirmed, :boolean, default: false
    add_column :authorizations, :confirmation_token, :string, default: nil
  end
end
