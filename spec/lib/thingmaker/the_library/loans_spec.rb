require 'rails_helper'
require 'nokogiri'
require 'thingmaker/the_library'

describe TheLibrary::Loans do

  let(:loans_fragment) { Nokogiri::HTML.fragment(File.read("spec/fixtures/loans_fragment.html")) }

  describe '#to_ical' do

    subject { TheLibrary::Loans.new(loans_fragment).to_ical }

    it 'returns an ical doc with events for each loan' do
      expect(subject.scan('BEGIN:VEVENT').size).to eq(2)
    end
  end

end

