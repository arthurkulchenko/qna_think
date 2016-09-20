FactoryGirl.define do
  factory :comment do
    content
    user
  end
  factory :comment_with_illegal_values, class: Comment do
    user nil
  end
end
