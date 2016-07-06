FactoryGirl.define do
  sequence(:content) { |n| "Content#{n}" }
  factory :answer do
    content 'You need to do ...'
    question
    user
  end
  factory :with_wrong_values, class: Answer do
    content nil
    question
    user
  end
end
