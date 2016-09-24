RSpec.describe QuestionsController, :type => :controller do
  let!(:user){ create(:user) }
#---------------------------------------------INDEX
  describe 'GET #index' do
    before { get :index }
    let(:questions){ create_list(:question, 3) }

    it 'assigns array of quesitons' do
      expect(assigns(:questions)).to match_array @questions
    end

    it 'renders template' do
      expect(response).to render_template :index
    end

  end
#---------------------------------------------NEW
  describe 'GET #new' do
    let(:question){ create(:question, user: user) }
    sign_in_user
    before { get :new }

    it 'renders template' do
      expect(response).to render_template :new
    end

    it 'assigns new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
  end
#---------------------------------------------SHOW
  describe 'GET #show' do
    let(:question){ create(:question, user: user) }
    before { get :show, id: question }

    it 'assigns right question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders template' do
      expect(response).to render_template :show
    end
  end
#---------------------------------------------POST(CREATE)
  describe 'POST #create' do
    let(:question){ create(:question, user: user) }
    sign_in_user
    context 'in success context  -- ' do
      let(:request) { post :create, question: attributes_for(:question), format: :js }
        it 'creates new question' do
          expect{request}.to change(Question, :count).by(1)
        end

        it 'redirect after save to #index' do
          request
          expect(response).to redirect_to question_path(assigns(:question))
        end

        it 'relate question with its user', format: :js do
          request
          expect(assigns(:question).user).to eq @user
        end
    end

    context 'in fail context  -- ' do
      let(:request) { post :create, question: attributes_for(:with_illegal_values), format: :js }
      it 'do not creates new question' do
        expect{request}.to_not change(Question, :count)
      end
    end
  end
#---------------------------------------------UPDATE
  describe 'PATCH #update' do
    let(:question){ create(:question, user: user) }
    sign_in_user
    let!(:question){ create(:question, user: @user) }
    let(:request) { patch :update, id: question, question: attributes_for(:question, content: "UNIQ"), format: :js }
    context 'successful' do
      it 'recive instance' do
        expect(assigns(:question)).to eq @question
      end
      it 'relates to its owner' do
        expect(subject.current_user).to eq question.user
      end
      it 'patching' do
        request
        question.reload
        expect(question.content).to eq "UNIQ"
      end
    end
    context 'fail' do
      let(:request) { patch :update, id: question, question: attributes_for(:with_wrong_values), format: :js }
      it 'do not patching' do
        request
        question.reload
        expect(question.content).to_not eq "UNIQ"
      end
    end
  end
#---------------------------------------------DELETE
  describe 'DELETE #destroy' do
    let(:question){ create(:question, user: user) }
    sign_in_user
    let!(:question){ create(:question, user: @user) }
    let(:request){ delete :destroy, id: question, format: :js }
    let(:another_user){ create(:user, email: 'another@email.rspec') }
    context 'owner deleting his question' do
      it 'deletes question' do
        expect{ request }.to change(Question, :count).by(-1)
      end

      it 'relates to its user' do
        expect(question.user).to eq subject.current_user
      end
      
      it 'redirects to index' do
        request
        expect(response).to redirect_to questions_path
      end
    end
    context 'not owner try to delete question' do
      sign_in_user
      it 'relates to its user' do
        expect(question.user).to_not eq subject.current_user
      end
      it 'do not delete question' do
        expect{ request }.to_not change(Question, :count)
      end
    end
  end
end