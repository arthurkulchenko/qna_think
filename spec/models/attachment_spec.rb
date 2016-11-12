RSpec.describe Attachment, type: :model do
  it { should belong_to :attachable }
  it_behaves_like "User Belongings"
end