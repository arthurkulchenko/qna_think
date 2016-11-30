require_relative '../acceptance_helper'

# ThinkingSphinx::ConnectionError:
#   Error connecting to Sphinx via the MySQL protocol. Error connecting to Sphinx via the MySQL protocol. 
#   Can't connect to MySQL server on '127.0.0.1' (61) - SELECT * FROM `answer_core`, `comment_core`, `question_core`, 
#   `user_core` WHERE MATCH('pancakes') AND `sphinx_deleted` = 0 LIMIT 0, 20; SHOW META

feature "searching", %q(
  In order to find something
  At least as guest
  I whant to search it  
  )do
    %w(question answer comment).each do |e|
      # global
      context "in #{e} search" do
        given!(:example){ create(e.to_sym, content: "pancakes") }
        background { visit root_path }

        scenario "it search #{e}", js: true do
          page.select(e.capitalize , from: 'area')
          fill_in "query", with: example.content
          click_on "Search"
          expect(page).to have_content "pancakes"
        end

        scenario "it do not search #{e.class}", js: true do
          page.select(e.capitalize , from: 'area')
          click_on "Search"
          expect(page).to_not have_content "pancakes"
          expect(page).to have_content "Nothing is found"
        end

      end
    end
  context "in user search" do
    given!(:user){ create(:user, email: "hello@mail.com") }
    background { visit root_path }
    scenario "it find user", js: true do
      page.select("User", from: "area")
      fill_in "query", with: user.email
      click_on "Search"
      expect(page).to have_content "hello@mail.com"
    end
  end

  context "in globla search" do
    given!(:user){ create(:user, email: "hello@mail.com") }
    background { visit root_path }
    scenario "it find user", js: true do
      page.select("Global", from: "area")
      fill_in "query", with: user.email
      click_on "Search"
      expect(page).to have_content "hello@mail.com"
    end
  end

end