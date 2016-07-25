RSpec.describe AnswersController, :type => :controller do
  let(:user) { create(:user) }
  sign_in_user
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 3, question: question, user: user) }
#---------------------------------------------#INDEX
  # describe 'GET #index' do
  #   before { get :index, params: { question_id: question }, session: { user_id: 1 } }
    
  #   it 'renders template' do
  #     expect(response).to render_template :index
  #   end

  #   it 'assigns array' do
  #     expect(assigns(:answers)).to match_array answers
  #   end

  # end
#---------------------------------------------#NEW
  # describe 'GET #new' do
  #   before { get :new, question_id: question }

  #   it 'assigns new instance' do
  #     expect(assigns(:answer)).to be_a_new(Answer)
  #   end

  #   it 'renders template' do
  #     expect(response).to render_template :new
  #   end
  # end
#---------------------------------------------#POST(CREATE)
  describe 'POST #create' do
      
    context 'seccess answer creating  --' do
      let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:answer), format: :js }
      it 'create new answer' do
        expect{ request }.to change(question.answers, :count).by(1)
      end

      it 'relate to its user' do
        request
        expect(assigns(:answer).user).to eq @user
      end
  
      it 'renders answers create' do
        request
        expect(response).to render_template 'answers/create'
      end
    
    end

    context 'fail answer creating  --' do
      # request.env['HTTP_REFERER'] = new_question_answer_path(question)
      let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:with_wrong_values), format: :js }
      it 'do not create new answer' do
        expect{ request }.to_not change(Answer, :count)
      end
  
      # it 'renders :new' do
      #   request
      #   expect(response).to render_template :new
      # end
    end
  end
#---------------------------------------------#SHOW
  # describe 'GET #show' do
  #   before { get :show, id: answer ,question_id: question }
    
  #   it 'renders template' do
  #     expect(response).to render_template :show
  #   end

  #   it 'recive instance' do
  #     expect(assigns(:answer)).to eq answer
  #   end
  # end
#---------------------------------------------DELETE
  describe 'DELETE #destroy' do
    sign_in_user
    let!(:question){ create(:question, user: @user) }
    let!(:answer){ create(:answer, question: question, user: @user) }
    let(:request){ delete :destroy, question_id: question, id: answer }
    let(:another_user){ create(:user, email: 'another@email.rspec') }
    context 'owner deleting his question' do
      it 'deletes question' do
        expect{ request }.to change(Answer, :count).by(-1)
      end

      it 'relates to its owner' do
        expect(subject.current_user).to eq answer.user
      end

      it 'redirects to question' do
        request
        expect(response).to redirect_to question_path(question)
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
