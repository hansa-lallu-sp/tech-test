# frozen_string_literal: true

require './lib/file_parser'
require 'tempfile'

describe FileParser do
  let(:file_path) do
    Tempfile.new(['test', '.log']).tap do |file|
      file.write(input)
      file.rewind
    end
  end

  let(:input) do
    <<~LOGFILE
      /index 1.2.3.4.5
      /home 5.4.3.2.1
      /contact 4.3.2.1.0
      /index 1.2.3.4.5
      /index 5.4.3.2.1
    LOGFILE
  end

  subject { described_class.new(file_path.path) }

  context '#initialize' do
    context 'with parameters' do
      it 'should take a file path' do
        expect(subject.file_path).to eq(file_path.path)
      end
    end

    context 'without parameters' do
      it 'errors if no file path provided' do
        expect { FileParser.new }.to raise_error(RuntimeError, 'File path not provided')
      end
    end
  end

  context '#parse_log_file' do
    let(:result) do
      { '/contact' => ['4.3.2.1.0'],
        '/home' => ['5.4.3.2.1'],
        '/index' => ['1.2.3.4.5', '1.2.3.4.5', '5.4.3.2.1'] }
    end

    it 'returns a hash of results' do
      expect(subject.parse_log_file).to eq(result)
    end
  end
end
