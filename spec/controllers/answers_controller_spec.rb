RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  sign_in_user
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 3, question: question, user: user) }
  let(:model){ Answer }
  let(:model_instanse) { answer }

#---------------------------------------------#POST(CREATE)
  describe 'POST #create' do
      
    context 'seccess answer creating  --' do
      let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:answer), format: :json }
      
      it 'create new answer' do
        expect{ request }.to change(question.answers, :count).by(1)
      end

      it 'relate to its user' do
        request
        expect(assigns(:answer).user).to eq @user
      end
    
    end

    context 'fail answer creating  --' do
      let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:with_wrong_values), format: :js }
      it 'do not create new answer' do
        expect{ request }.to_not change(Answer, :count)
      end
  
    end
  end
#---------------------------------------------UPDATE
  describe 'PATCH #update' do
    let!(:question){ create(:question, user: @user) }
    let!(:answer){ create(:answer, question: question, user: @user) }
    let(:request) { patch :update, id: answer, question_id: question, answer: attributes_for(:answer, content: "UNIQ"), format: :js }
    context 'successful' do
      it 'recive instance' do
        expect(assigns(:answer)).to eq @answer
      end
      it 'relates to its owner' do
        expect(subject.current_user).to eq answer.user
      end
      it 'patching' do
        request
        answer.reload
        expect(answer.content).to eq "UNIQ"
      end
    end
    context 'fail' do
      let(:request) { patch :update, id: answer, question_id: question, answer: attributes_for(:with_wrong_values), format: :js }
      it 'do not patching' do
        request
        answer.reload
        expect(answer.content).to_not eq "UNIQ"
      end
    end
  end
#---------------------------------------------DELETE
  describe 'DELETE #destroy' do
    let!(:question){ create(:question, user: @user) }
    let!(:answer){ create(:answer, question: question, user: @user) }

    let(:request){ delete :destroy, question: question, id: answer, format: :js }
    let(:another_user){ create(:user, email: 'another@email.rspec') }
    context 'owner deleting his question' do
      it 'deletes question' do
        expect{ request }.to change(Answer, :count).by(-1)
      end

      it 'relates to its owner' do
        expect(subject.current_user).to eq answer.user
      end

    end
    context 'not owner try to delete question' do
      sign_in_user
      it 'relates to its user' do
        expect(answer.user).to_not eq subject.current_user
      end
      it 'do not delete questoin' do
        expect{ request }.to_not change(Answer, :count)
      end
    end
  end
  
end
