FactoryGirl.define do
  factory :question do
    title
    content

    trait :with_strong_parametrs do
      title 'HI'
      content 'Hallo'
    end
  end
end
