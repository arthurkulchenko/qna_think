FactoryGirl.define do
  factory :comment do
    content
    user
    comments_parent_type 'Question'
  end
  factory :comment_with_wrong_values, class: Comment do
    user nil
  end
end
