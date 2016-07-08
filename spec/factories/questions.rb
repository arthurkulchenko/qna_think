FactoryGirl.define do
  factory :question do
    title "-title-"
    content "-content-"
    user
  end

  factory :with_illegal_values, class: Question do
    title nil
    content nil
    user nil
  end
end
