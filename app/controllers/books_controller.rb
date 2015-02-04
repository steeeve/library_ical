require 'thingmaker/the_library'

class BooksController < ApplicationController
  before_action :set_loans, only: [:index]

  def index
    respond_to do |format|
      format.json { render :json => @loans }
      format.ics { render :text => @loans.to_ical, content_type: 'text/calendar; charset=utf-8' }
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
      @loans = Rails.cache.fetch("#{borrower_number}:loans", :expires_in => 12.hours) do
        borrower.loans
      end
    end

end
