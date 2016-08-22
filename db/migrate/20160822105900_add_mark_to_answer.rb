class AddMarkToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :mark, :integer, default: 0
    add_column :questions, :mark, :integer, default: 0
  end
end
