FactoryGirl.define do
  factory :attachment do
    file File.open(Rails.root.join('README.md'), 'r')
    attachable_kind "MyString"
    user
  end
end
