require 'thingmaker/library_loans'

class BooksController < ApplicationController
  before_action :set_books, only: [:index]

  def index
    respond_to do |format|
      format.json { render :json => @books }
    end
  end

  private

    def library_loans
      @library_loans ||= Thingmaker::LibraryLoans.new(borrower_number)
    end

    def set_books
      @books = library_loans.loans
    end

    def borrower_number
      params['borrower']
    end

end
