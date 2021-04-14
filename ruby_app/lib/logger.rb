# frozen_string_literal: true

require_relative 'file_parser'

class Logger
  def initialize(contents)
    @contents = contents
  end

  def print_results
    print_visits
    puts ''
    print_unique
  end

  def print_unique
    description = 'unique views'
    header = 'Unique page views:'

    format(sort_desc(@contents.transform_values { |ips| ips.uniq.count }), header, description)
  end

  def print_visits
    description = 'visits'
    header = 'Total page views:'

    format(sort_desc(@contents.transform_values(&:count)), header, description)
  end

  private

  def sort_desc(results)
    results.sort_by { |_k, v| v }.reverse
  end

  def format(results, header, description)
    puts header
    results.to_h.each { |k, v| puts "#{k} #{v} #{description}" }
  end
end
