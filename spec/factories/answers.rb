FactoryGirl.define do
  sequence(:content) { |n| "sequenced content -- #{n}" }
  sequence(:best_answer) { |n| true if n > 2 }
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
