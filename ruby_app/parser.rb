#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/logger'
require_relative 'lib/file_parser'

file_parser = FileParser.new(ARGV[0])
Logger.new(file_parser.parse_log_file).print_results
