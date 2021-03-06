require_relative '../acceptance_helper'

feature 'listing all question', %q(
  In order to find a similar question
  As a regular user
  I want to get list of all questions
) do

    given!(:questions) { create_list(:question, 2) }

    scenario ' indexing questions' do
      visit questions_path
      questions.each do |question| 
        expect(page).to have_content question.title
      end
    end
end