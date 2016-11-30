require_relative '../acceptance_helper'

feature "searching", %q(
  In order to find some answer
  As guest
  I whant to search it  
  )do
  #   given!(:some_subject){ create(:answer) }
  #   given!(:attribute){ :content }
  #   # it_behaves_like 'SerchingWithSphinx'
  #   before { visit root_path }
  # scenario "it search #{some_subject.class}", js: true do
  #   select(some_subject.class, from: 'area')
  #   fill_in "query", with: "#{some_subject.send(attribute)}"
  #   click_on "Search"
  #   expect(page).to have_content some_subject.send(attribute)
  # end

  # scenario "#{some_subject.class} does't exist", js: true do
  #   select(some_subject, from: 'area')
  #   click_on "Search"
  #   expect(page).to_not have_content some_subject.send(attribute)
  # end
    given!(:answer){ create(:answer) }
    # given!(:attribute){ :content }
    # it_behaves_like 'SerchingWithSphinx'
    before { visit root_path }
    scenario "it search answer", js: true do
      page.select("Answer", from: 'area')
      fill_in "query", with: answer.content
      save_and_open_page
      click_on "Search"
      save_and_open_page
      expect(page).to have_content answer.content
    end

    scenario "Answer does't exist", js: true do
      select("Answer", from: 'area')
      click_on "Search"

      expect(page).to_not have_content answer.content
      expect(page).to have_content "Nothing is found"
    end
end