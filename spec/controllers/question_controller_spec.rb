require 'rails_helper'

RSpec.describe QuestionController, :type => :controller do
  describe 'GET #index' do
  	before { get :index }
  	let(:questions) { create_list(:question, 3) }

    it 'assigns array of quesitons' do
      expect(assigns(:questions)).to match_array @questions
    end

    it 'renders template'

  end

  describe 'GET #new' do
  	it 'renders template'
  	it 'assigns new question'
  end

  describe 'POST #create' do
  	context 'in success context  -- ' do
  	  it 'redirect after save to #index'
  	  it 'creates new question'
  	end
  end

end
