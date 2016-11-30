require_relative '../acceptance/acceptance_helper'
RSpec.describe SearchingsController, type: :controller do
  
  describe "POST#create" do
    %w(global user question answer comment).each do |e|
      context "in #{e} search" do
        # it_behaves_like "SearchController"
        let(:attr_is){ e == "user" ? :email : :content }
        let(e.to_sym){ create(e.to_sym, attr_is => "pancakes") }
        let(:search){ThinkingSphinx.search 'pancakes', :indices => ["#{e}_core"]}
        it "render #{e}" do
          expect{search}
        end
      end
    end
    # context "in global search" do
    #   it_behaves_like "SearchController"
    # end
    # context "in user search" do
    #   it_behaves_like "SearchController"
    # end
    # context "in question search" do
    #   it_behaves_like "SearchController"
    # end
    # context "in answer search" do
    #   it_behaves_like "SearchController"
    # end
    # context "in comment search" do
    #   it_behaves_like "SearchController"
    # end
  end
end