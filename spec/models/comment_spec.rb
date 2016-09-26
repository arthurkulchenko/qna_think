RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :content }
  it { should validate_presence_of :parent_type }
end