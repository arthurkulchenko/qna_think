class AddBestAnswerToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :best_answer, :bool, default: false, comment: 'For deside wich answer is better or the best'
  end
end
