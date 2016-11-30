require_relative '../acceptance/acceptance_helper'
RSpec.describe SearchingsController, type: :controller do
  
  describe "POST#create" do
    %w(global user question answer comment).each do |e|
      context "in #{e} search" do
        let(:attr_is){ e == "user" ? :email : :content }
        let(e.to_sym){ create(e.to_sym, attr_is => "pancakes") }
        
        let(:search){ThinkingSphinx.search 'pancakes', :indices => ["#{e}_core"]}
        let(:request) { post :create, "area"=> e.capitalize, "query"=>"pancakes", format: :json }
        
        # it "searching" do
        	# , :indices => ["#{e}_core"]
          # expect(ThinkingSphinx).to receive(:search).with("pancakes").and_call_original
        #   request
        # end

        before { request }
        it_behaves_like "Success status"
      end
    end
  end
end