RSpec.describe Question, type: :model do

  subject{ build(:question) }
  it { should validate_presence_of :content }
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should accept_nested_attributes_for :attachments }
  it_behaves_like "User Belongings"
end