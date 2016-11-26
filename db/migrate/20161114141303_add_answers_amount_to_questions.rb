class AddAnswersAmountToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :answers_amount, :integer
  end
end
