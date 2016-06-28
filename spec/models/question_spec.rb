require 'rails_helper'

RSpec.describe Question, :type => :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:title) }
end
