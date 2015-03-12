require 'thingmaker/the_library'

class LoansController < ApplicationController
  before_action :set_loans, only: [:index]

  def index
    respond_to do |format|
      format.json
      format.ics { render :text => @loans.to_ics, content_type: 'text/calendar; charset=utf-8' }
    end
  end

  private

    def borrower_number
      params['borrower']
    end

    def borrower
      @borrower ||= TheLibrary::Borrower.new(borrower_number)
    end

    def set_loans
      @loans = borrower.loans
    end

end
