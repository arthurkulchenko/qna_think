RSpec.describe Comment, type: :model do
  subject{ build(:comment) }
  it_behaves_like "User Belongings"
  it { should validate_presence_of :parent_type }
  it { should validate_presence_of :content }
end