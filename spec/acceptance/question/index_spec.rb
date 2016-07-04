require_relative '../acceptance_helper'

feature 'listing all question', %q(
  In order to find a similar question
  As a regular user
  I want to get list of all questions
) do

    given!(:questions) { create_list(:question, 2) }
    # given(:answers) { create_list(:answer, 2, question_id: _question) }

    scenario ' indexing questions' do
      visit question_index_path
      questions.each do |question| 
        expect(page).to have_content question.title
      end
    end
end