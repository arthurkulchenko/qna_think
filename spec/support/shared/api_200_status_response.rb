shared_examples_for "Success status" do
  it 'return 200 status' do
    expect(response).to be_success
  end
end