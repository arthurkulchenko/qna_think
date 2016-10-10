RSpec.describe Attachment, type: :model do
  it { should belong_to :attachable }
  it { should belong_to :user }
  it { should validate_presence_of(:user_id) }
end