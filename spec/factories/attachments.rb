FactoryGirl.define do
  factory :attachment do
    file File.open(Rails.root.join('README.md'), 'r')
    user
  end
end
