shared_examples "tokenable" do
  it "generates a random token when the model is created" do
    expect(object.token).to be_present
  end
end
