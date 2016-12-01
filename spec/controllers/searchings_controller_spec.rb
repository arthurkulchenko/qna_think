require_relative '../acceptance/acceptance_helper'
RSpec.describe SearchingsController, type: :controller do
  
  describe "POST#create" do
    %w(global user question answer comment).each do |e|
      context "in #{e} search" do        
        let(:attr_is){ e == "user" ? :email : :content }
        let(e.to_sym){ create(e.to_sym, attr_is => "pancakes") }
        before { post :create, "area"=> e.capitalize, "query"=>"pancakes", format: :json }
        it_behaves_like "Success status"
      end
    end
  end
end
# ThinkingSphinx::ConnectionError:
#   Error connecting to Sphinx via the MySQL protocol. Error connecting to Sphinx via the MySQL protocol. 
#   Can't connect to MySQL server on '127.0.0.1' (61) - SELECT * FROM `answer_core`, `comment_core`, `question_core`, 
#   `user_core` WHERE MATCH('pancakes') AND `sphinx_deleted` = 0 LIMIT 0, 20; SHOW META