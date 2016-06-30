FactoryGirl.define do
  factory :question do
    title "-title-"
    content "-content-"
  end

  factory :with_illegal_values, class: Question do
    title nil
    content nil
  end
end
