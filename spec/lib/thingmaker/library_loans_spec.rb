require 'rails_helper'
require 'thingmaker/library_loans'

module Thingmaker

  RSpec.describe LibraryLoans do

    before do
      @library_loans = LibraryLoans.new(ENV['BORROWER_NUMBER'])
    end

    describe "loans", :vcr do

      let(:loans) { @library_loans.loans }

      it "returns an array of Loan Structs" do
        expect(loans.size).to eq(4)
      end
    end

  end

end
