RSpec.describe CommentsController, type: :controller do
  let(:user){ create(:user) }
  let(:question){ create(:question, user: user) }
  let(:answer){ create(:answer, user: user, question: question) }
  let(:comment){ create(:comment, user: user, parent: question) }
  let(:comment2){ create(:comment, user: user, parent: answer) }
  let(:model){ Comment }
  let(:model_instanse){ comment }
  let(:model_instanse2){ comment2 }
  # -------------
  # let(:options){ answer_id: model_instanse, comment: attributes_for(:comment_with_wrong_values) }
  sign_in_user
#---------------------------------------------POST(CREATE)
  describe 'POST #create' do
    # it_behaves_like "Post method"
    context 'in success context  -- ' do
      let(:request) { post :create, id: :comment2, answer_id: answer, comment: attributes_for(:comment), format: :js }
        it 'creates new comment' do
          expect{request}.to change(Comment, :count).by(1)
        end

        it 'relate comment with its user' do
          request
          expect(assigns(:comment).user).to eq @user
        end
    end

    context 'in fail context  -- ' do      
      let(:request) { post :create, id: :comment2, answer_id: answer, comment: attributes_for(:comment_with_wrong_values), format: :js }
      it 'do not creates new comment' do
        expect{request}.to_not change(Comment, :count)
      end
    end
  end
#---------------------------------------------DELETE
  describe 'DELETE #destroy' do
    let!(:question){ create(:question, user: @user) }
    let!(:answer){ create(:answer, user: user, question: question) }
    let!(:comment){ create(:comment, parent: answer, user: @user) }
    let(:request){ delete :destroy, answer_id: answer, id: comment, format: :js }
    let(:another_user){ create(:user, email: 'another@email.rspec') }
    context 'owner deleting his comment' do
      it 'deletes comment' do
        expect{ request }.to change(Comment, :count).by(-1)
      end
      it 'relates to its user' do
        expect(comment.user).to eq subject.current_user
      end
    end
    context 'not owner try to delete comment' do
      sign_in_user
      it 'relates to its user' do
        expect(comment.user).to_not eq subject.current_user
      end
      it 'do not delete question' do
        expect{ request }.to_not change(Comment, :count)
      end
    end
  end

#---------------------------------------------#POST(CREATE)
  describe 'POST #create' do
    context 'success comment creating  --' do
      let(:request) { post :create, id: :comment, question_id: question, comment: attributes_for(:comment), format: :js }
      it 'create new comment' do
        expect{ request }.to change(Comment, :count).by(1)
      end
      it 'relate to its user' do
        request
        expect(assigns(:comment).user).to eq @user
      end
    end

    context 'fail comment creating  --' do
      let(:request) { post :create, id: :comment, question_id: question, comment: attributes_for(:comment_with_wrong_values), format: :js }
      it 'do not create new comment' do
        expect{ request }.to_not change(Comment, :count)
      end
  
    end
  end
#---------------------------------------------DELETE
  describe 'DELETE #destroy' do
    let!(:question){ create(:question, user: @user) }
    let!(:comment){ create(:comment, parent: question, user: @user) }
    let(:request){ delete :destroy, question_id: question, id: comment, format: :js }
    let(:another_user){ create(:user, email: 'another@email.rspec') }
    context 'owner deleting his comment' do
      it 'deletes comment' do
        expect{ request }.to change(Comment, :count).by(-1)
      end

      it 'relates to its owner' do
        expect(subject.current_user).to eq comment.user
      end

    end
    context 'not owner try to delete comment' do
      sign_in_user
      it 'relates to its user' do
        expect(comment.user).to_not eq subject.current_user
      end
      it 'do not delete comment' do
        expect{ request }.to_not change(Comment, :count)
      end
    end
  end
end