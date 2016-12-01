RSpec.describe Search, type: :model do
  describe ".for method" do

    %w(global user question answer comment).each do |e|
      context "in #{e} search" do
        let(:attr_is){ e == "user" ? :email : :content }
        let(e.to_sym){ create(e.to_sym, attr_is => "pancakes") }
        it "searching" do
          expect(ThinkingSphinx).to receive(:search).with("pancakes", :indices => ["#{e}_core"]).and_call_original
          ThinkingSphinx.search 'pancakes', :indices => ["#{e}_core"]
        end
      end
    end

  end
end