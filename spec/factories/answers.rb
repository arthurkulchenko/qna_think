FactoryGirl.define do
  sequence(:content) { |n| "sequenced content -- #{n}" }
  sequence(:best_answer) { |n| n > 2 ? true : false }
  factory :answer do
    content
    question
    user
    best_answer
  end

  factory :with_wrong_values, class: Answer do
    content nil
    question
    user
  end
end
