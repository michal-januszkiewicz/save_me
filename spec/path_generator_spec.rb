require "spec_helper"

describe PathGenerator do
  subject { PathGenerator }

  describe "#call" do
    let(:filepath) { "test_result.csv" }
    let(:generate_path) { subject.call(filepath, "results", ymd) }
    let(:time) { Time.new(2017, 03, 30, 9, 4, 55, "+02:00") }

    before do
      allow(Time).to receive(:now).and_return(time)
    end

    it_behaves_like "valid path genarator", ymd: 0b000, path: "results/2017_03_30_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b001, path: "results/30/2017_03_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b010, path: "results/3/2017_30_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b011, path: "results/3/30/2017_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b100, path: "results/2017/03_30_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b101, path: "results/2017/30/03_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b110, path: "results/2017/3/30_09:04:55"
    it_behaves_like "valid path genarator", ymd: 0b111, path: "results/2017/3/30/09:04:55"
  end
end
