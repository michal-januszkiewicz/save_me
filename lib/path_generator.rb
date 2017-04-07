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
    File.join(produce_path, produce_dirname)
  end

  private

  def produce_path
    parts = []
    parts.push(results_path)
    parts.push(timestamp.year.to_s) if year
    parts.push(timestamp.month.to_s) if month
    parts.push(timestamp.day.to_s) if day
    File.join(*parts)
  end

  def produce_dirname
    str = ""
    str += "%Y_" unless year
    str += "%m_" unless month
    str += "%d_" unless day
    str += "%H-%M-%S"
    timestamp.strftime(str)
  end
end
