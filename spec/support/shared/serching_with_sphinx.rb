shared_examples_for "SerchingWithSphinx" do
  before { visit root_path }
  scenario "it search #{subject.class}", js: true do
    select(subject, from: 'area')
    fill_in "query", with: "#{subject.send(attribute)}"
    click_on "Search"
    expect(page).to have_content subject.send(attribute)
  end

  scenario "#{subject.class} does't exist", js: true do
    select(subject, from: 'area')
    click_on "Search"
    expect(page).to_not have_content subject.send(attribute)
  end
end
