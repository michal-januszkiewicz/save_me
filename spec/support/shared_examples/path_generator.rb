RSpec.shared_examples "valid path genarator" do |params|
  let(:ymd) { params[:ymd] }
  it "genarates correct path" do
    expect(generate_path).to eq(params[:path])
  end
end
