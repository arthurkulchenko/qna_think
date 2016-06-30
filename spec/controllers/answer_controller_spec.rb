require 'rails_helper'

# def necessary_template
#   @name = self.name #metadata #.description
#   @index = @name.rindex('#')
#   @necessary_template = @name[@index.next..-1].to_sym
# end

RSpec.describe AnswerController, :type => :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:answers) { create_list(:answer, 3, question: question) }

  describe 'GET #index' do
  	before { get :index, question_id: question }
  	
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
  	let(:request) { post :create, id: :answer, question_id: question, answer: attributes_for(:answer) }

  	it 'create new answer' do
  	  expect{ request }.to change(Answer, :count).by(1)
  	end

  	it 'redirects to question_path' do
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
