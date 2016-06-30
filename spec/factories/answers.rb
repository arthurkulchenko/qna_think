FactoryGirl.define do
  factory :answer do
    content 'Hallo'
    question
  end
  factory :with_wrong_values, class: Answer do
    content nil
  end
end
