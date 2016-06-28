class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.belongs_to :question, foreign_key: true, index: true
      t.string :content
      t.timestamps
    end
  end
end
