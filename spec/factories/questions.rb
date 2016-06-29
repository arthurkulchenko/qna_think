FactoryGirl.define do
  factory :question do
    title "-title-"
    content "-content-"

    trait :with_strong_parametrs do
      title "-title-"
      content "-content-"
    end

    trait :with_illegal_values do
      title nil
      content nil
    end
  end
end
