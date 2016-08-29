FactoryGirl.define do
  factory :vote do
    ballot
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
end
