require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:questions).dependet(:destroy) }
  it { should have_many(:answers).dependet(:destroy) }
end
