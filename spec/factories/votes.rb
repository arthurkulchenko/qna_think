FactoryGirl.define do
  factory :vote do
    user
    mark 0
  end

  factory :voted_plus, class: Vote do
    user 
    mark 1
  end

  factory :voted_minus, class: Vote do
    user 
    mark -1
  end

  factory :voted_neutral, class: Vote do
    user 
    mark 0
  end

  factory :illigal_voted, class: Vote do
    user 
    mark -2
  end
end
