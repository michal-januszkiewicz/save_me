require "save_me/version"
require "path_generator"
require "json"

class SaveMe
  attr_reader :filepath, :new_filepath, :params

  def self.call(filepath, results_path: "./", ymd: 0b111, params: nil)
    new(filepath, results_path, ymd, params).call
  end

  def initialize(filepath, results_path, ymd, params)
    @filepath = filepath
    @new_filepath = PathGenerator.call(filepath, results_path, ymd)
    @params = params
  end

  def call
    create_dir
    copy_file
    save_params
  end

  private

  def create_dir
    FileUtils.mkdir_p(new_filepath)
  end

  def copy_file
    FileUtils.cp_r(filepath, new_filepath)
  end

  def save_params
    return nil unless params
    params_path = "#{new_filepath}/params.json"
    File.open(params_path, "w") do |file|
      file << params.to_json
    end
  end
end
