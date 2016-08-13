RSpec.describe Question, :type => :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:title) }
  it { should accept_nested_attributes_for :attachments }
end
