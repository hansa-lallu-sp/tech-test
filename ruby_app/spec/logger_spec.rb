# frozen_string_literal: true

require './lib/logger'

describe Logger do
  let(:contents) do
    { '/contact' => ['4.3.2.1.0'],
      '/home' => ['5.4.3.2.1'],
      '/index' => ['1.2.3.4.5', '1.2.3.4.5', '5.4.3.2.1'] }
  end

  let(:visits_result) do
    <<~TEXT
      Total page views:
      /index 3 visits
      /home 1 visits
      /contact 1 visits
    TEXT
  end

  let(:unique_visits_result) do
    <<~TEXT
      Unique page views:
      /index 2 unique views
      /home 1 unique views
      /contact 1 unique views
    TEXT
  end

  let(:results) do
    "#{visits_result}\n#{unique_visits_result}"
  end

  subject { described_class.new(contents) }

  context '#print_visits' do
    it 'prints a header' do
      expect { subject.print_visits }.to output(/Total page views:/).to_stdout
    end

    it 'prints a description' do
      expect { subject.print_visits }.to output(/visits/).to_stdout
    end

    it('prints results in desc order') do
      expect { subject.print_visits }.to output(visits_result).to_stdout
    end
  end

  context '#print_unique_visits' do
    it 'prints a header' do
      expect { subject.print_unique }.to output(/Unique page views:/).to_stdout
    end

    it 'prints a description' do
      expect { subject.print_unique }.to output(/unique views/).to_stdout
    end

    it('prints results in desc order') do
      expect { subject.print_unique }.to output(unique_visits_result).to_stdout
    end
  end

  context '#print_results' do
    it 'outputs both visits and unique visits' do
      expect { subject.print_results }.to output(results).to_stdout
    end
  end
end
