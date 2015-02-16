require 'rails_helper'
require 'nokogiri'
require 'thingmaker/the_library'

describe TheLibrary::Loan do

  let(:loan_fragment) { Nokogiri::HTML.fragment(File.read("spec/fixtures/loan_fragment.html")) }
  let(:expected_date) { Date.new(2015, 2, 17) }  # This will break in 2016

  subject { TheLibrary::Loan.new(loan_fragment) }

  it 'knows the title' do
    expect(subject.title).to eq("A Midsummer Night's Dream")
  end

  it 'knows the author' do
    expect(subject.author).to eq('Shakespeare, William, 1564-1616')
  end

  it 'knows the due date' do
    expect(subject.due_date).to eq(expected_date)
  end

end
