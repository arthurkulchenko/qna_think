RSpec.describe MergingUsersJob, type: :job do
  describe ".merging_users" do
    let!(:user){ create(:user) }
    let!(:user_2){ create(:user) }
    
    context "it merge users" do
      before { MergingUsersJob.perform_now(user, user_2) }

      it 'deletes old user' do
        expect(user).to be_destroyed
      end

      it 'updates old users associations' do
        User.associations_list.each do |association|
          user.send(association).each { |i| expect (i.user).to eq user_2 }
        end
      end
    end
  end
end