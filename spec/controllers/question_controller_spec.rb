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
    it 'assigns right question'
    it 'renders template'
  end

  describe 'POST #create' do
    # before { post :create }
    let(:question) { create(:question, :with_strong_parametrs) }
    let(:request) { post 'create', question: attributes_for(:question) }

  	context 'in success context  -- ' do
      it 'assigns new question' do
        request
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'creates new question' do
        request
        expect { request }.to change(Question, :count).by(1)
      end

  	  it 'redirect after save to #index' do
        request
        expect(response).to redirect_to question_path(assigns(:question))
      end
  	  
  	end
  end

end
