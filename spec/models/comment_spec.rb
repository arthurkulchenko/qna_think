require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { validate_presence_of :user_id }
  it { validate_presence_of :content }
  it { validate_presence_of :parent_type }
  # DO NOT FAILS
  it { validate_presence_of :comments_parent_type }
end
