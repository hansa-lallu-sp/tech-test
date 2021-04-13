# frozen_string_literal: true

class FileParser
  attr_reader :file_path

  def initialize(file_path = nil)
    @file_path = file_path
    validate_file_path
    @results = Hash.new { |hash, key| hash[key] = [] }
  end

  def parse_log_file
    read_file.each do |line|
      path, ip_address = line.split(' ')
      add_result(path, ip_address)
    end

    @results
  end

  private

  def read_file
    File.open(file_path)
  end

  def add_result(path, ip_address)
    @results[path].push(ip_address)
  end

  def validate_file_path
    file_path_not_provided
  end

  def file_path_not_provided
    raise 'File path not provided' if file_path.nil?
  end
end
