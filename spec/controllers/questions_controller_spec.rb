RSpec.describe QuestionsController, :type => :controller do
  let!(:user){ create(:user) }
  let(:question){ create(:question, user: user) }
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
    sign_in_user
    context 'in success context  -- ' do
      let(:request) { post :create, question: attributes_for(:question) }
        it 'creates new question' do
          expect{request}.to change(Question, :count).by(1)
        end

        it 'redirect after save to #index' do
          request
          expect(response).to redirect_to question_path(assigns(:question))
        end

        it 'relate question with its user' do
          request
          expect(assigns(:question).user).to eq @user
        end
    end

    context 'in fail context  -- ' do

      # post "/sessions", {:session => {:email => user.email, 
      #   :password => user.password}}, {"HTTPS" => "on", 'HTTP_REFERER' => '/signin'}
      
      # let(:request) { post :create, :session => { :title => nil, :content => nil}, {'HTTP_REFERER' => '/question/new'}
      # request.env["HTTP_REFERER"] = "/question/new"
      
      let(:request) { post :create, question: attributes_for(:with_illegal_values) }
      it 'do not creates new question' do
        expect{request}.to_not change(Question, :count)
      end

      it 'renders :new' do
        request
        expect(response).to render_template :new
      end
    end
  end
#---------------------------------------------DELETE
  describe 'DELETE #destroy' do
    sign_in_user
    let!(:question){ create(:question, user: @user) }
    let(:request){ delete :destroy, id: question }
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