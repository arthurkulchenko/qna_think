require 'rails_helper'

RSpec.describe QuestionController, :type => :controller do
  let(:question) { create(:question) }
  let(:questions) { create_list(:question, 3) }
  
  describe 'GET #index' do
  	before { get :index }

    it 'assigns array of quesitons' do
      expect(assigns(:questions)).to match_array @questions
    end

    it 'renders template' do
      expect(response).to render_template :index
    end

  end

  describe 'GET #new' do
    before { get :new }

  	it 'renders template' do
  	  expect(response).to render_template :new
  	end

  	it 'assigns new question' do
  	  expect(assigns(:question)).to be_a_new(Question)
  	end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns right question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders template' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do

  	context 'in success context  -- ' do
    let(:request) { post :create, question: attributes_for(:question) }
      it 'creates new question' do
        expect{request}.to change(Question, :count).from(0).to(1)
      end

  	  it 'redirect after save to #index' do
        request
        expect(response).to redirect_to question_path(assigns(:question))
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

      it 'redirect to back if does not save' do
        request
        expect(response).to redirect_to new_question_path
      end
      
    end
  end

end
