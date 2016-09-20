FactoryGirl.define do
  sequence(:content) { |n| "sequenced content -- #{n}" }
  factory :comment do
    comment
    user
  end
  factory :with_illegal_values, class: Comment do
    user nil
  end
end
