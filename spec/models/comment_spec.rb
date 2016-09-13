require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { validate_presence_of :user_id }
end
