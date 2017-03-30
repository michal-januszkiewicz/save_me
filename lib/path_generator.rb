class PathGenerator
  attr_reader :filepath, :results_path, :year, :month, :day, :timestamp

  def self.call(filepath, results_path, ymd)
    new(filepath, results_path, ymd).call
  end

  def initialize(filepath, results_path, ymd)
    @filepath = filepath
    @results_path = results_path
    @year = ymd & 0b100 != 0
    @month = ymd & 0b010 != 0
    @day = ymd & 0b001 != 0
    @timestamp = Time.now
  end

  def call
    produce_path + produce_dirname
  end

  private

  def produce_path
    str = results_path
    str += "/" unless results_path[-1] == "/"
    str += "#{timestamp.year}/" if year
    str += "#{timestamp.month}/" if month
    str += "#{timestamp.day}/" if day
    str
  end

  def produce_dirname
    str = ""
    str += "%Y_" unless year
    str += "%m_" unless month
    str += "%d_" unless day
    str += "%H:%M:%S"
    timestamp.strftime(str)
  end
end
