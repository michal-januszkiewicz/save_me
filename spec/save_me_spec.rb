require "spec_helper"
require "fakefs/safe"
require "fileutils"

describe SaveMe do
  subject { SaveMe }
  let(:archive_file) { subject.call(filepath, results_path: results_path, ymd: ymd, params: params) }
  let(:path) { "./script/" }
  let(:filename) { "results.csv" }
  let(:filepath) { path + filename }
  let(:results_path) { "results" }
  let(:ymd) { 0b111 }
  let(:params) { nil }
  let(:time) { Time.new(2017, 03, 30, 9, 4, 55, "+02:00") }

  describe "#call" do
    before do
      allow(Time).to receive(:now).and_return(time)
    end

    context "when there is only one file and method is called" do
      before do
        FakeFS do
          FileUtils.mkdir_p(path)
          FileUtils.touch(filepath)
          archive_file
        end
      end

      it "creates a directory" do
        FakeFS do
          expect(File.directory?("results/2017/3/30/09:04:55")).to eq(true)
        end
      end

      it "copies the file" do
        FakeFS do
          expect(File.file?("results/2017/3/30/09:04:55/#{filename}")).to eq(true)
        end
      end

      context "when params are not filled" do
        it "creates no params file" do
          FakeFS do
            expect(File.file?("results/2017/3/30/09:04:55/params.json")).to eq(false)
          end
        end
      end

      context "when params are filled" do
        let(:params) { { arg1: 1, arg2: 2 } }
        before { FakeFS { archive_file } }

        it "creates a params file" do
          FakeFS do
            expect(File.file?("results/2017/3/30/09:04:55/params.json")).to eq(true)
          end
        end
      end
    end

    context "when there is a folder file and method is called" do
      let(:filename) { "results" }
      let(:file1) { "#{filepath}/file1.csv" }
      let(:file2) { "#{filepath}/file2.csv" }
      before do
        FakeFS do
          FileUtils.mkdir_p(filepath)
          FileUtils.touch(file1)
          FileUtils.touch(file2)
          archive_file
        end
      end

      it "creates a directory" do
        FakeFS do
          expect(File.directory?("results/2017/3/30/09:04:55/results")).to eq(true)
        end
      end

      it "creates both files" do
        FakeFS do
          expect(File.file?("results/2017/3/30/09:04:55/results/file1.csv")).to eq(true)
          expect(File.file?("results/2017/3/30/09:04:55/results/file2.csv")).to eq(true)
        end
      end
    end
  end
end
