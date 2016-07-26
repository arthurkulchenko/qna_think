FactoryGirl.define do
  sequence(:content) { |n| "Content#{n}" }
  factory :answer do
    content
    question
    user
  end
  # factory :new_answer, class: Answer do
  #   content "UNIQ"
  #   question
  #   user
  # end
  factory :with_wrong_values, class: Answer do
    content nil
    question
    user
  end
end
