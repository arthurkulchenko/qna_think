require 'rails_helper'

RSpec.describe QuestionController, :type => :controller do
  let(:question) { create(:question, :with_strong_parametrs) }
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
    let(:request) { post :create, id: question, question: attributes_for(:question) }

  	context 'in success context  -- ' do

      it 'creates new question' do
        expect { request }.to change(Question, :count).by(1)
      end

  	  it 'redirect after save to #index' do
        request
        expect(response).to redirect_to question_path(assigns(:question))
      end
  	  
  	end
  end

end
