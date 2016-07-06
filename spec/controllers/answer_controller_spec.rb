require 'rails_helper'

# def necessary_template
#   @name = self.name #metadata #.description
#   @index = @name.rindex('#')
#   @necessary_template = @name[@index.next..-1].to_sym
# end

RSpec.describe AnswerController, :type => :controller do
  let(:user) { create(:user) }
  sign_in_user
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 3, question: question, user: user) }

  describe 'GET #index' do
  	before { get :index, params: { question_id: question }, session: { user_id: 1 } }
  	
  	it 'renders template' do
  	  expect(response).to render_template :index
  	end

  	it 'assigns array' do
  	  expect(assigns(:answers)).to match_array answers
  	end

  end

  describe 'GET #new' do
    before { get :new, question_id: question }

  	it 'assigns new instance' do
  	  expect(assigns(:answer)).to be_a_new(Answer)
  	end

  	it 'renders template' do
  	  expect(response).to render_template :new
  	end
  end

  describe 'POST #create' do
    context 'registred user try to create answer' do
    end
    context 'unregistred user try to create answer' do
    end
  	
    context 'seccess answer creating  --' do
      let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:answer) }
  	  it 'create new answer' do
  	    expect{ request }.to change(question.answers, :count).by(1)
  	  end
  
  	  it 'redirects to question_path' do
        request
        expect(response).to redirect_to question_path(question)
  	  end
    context 'fail to creat answer' do
    end
    end

    context 'fail answer creating  --' do
      # request.env['HTTP_REFERER'] = new_question_answer_path(question)
      let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:with_wrong_values) }
      it 'do not create new answer' do
        expect{ request }.to_not change(Answer, :count)
      end
  
      it 'renders :new' do
        request
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
  	before { get :show, id: answer ,question_id: question }
  	
  	it 'renders template' do
  	  expect(response).to render_template :show
  	end

  	it 'recive instance' do
  	  expect(assigns(:answer)).to eq answer
  	end
  end
end
