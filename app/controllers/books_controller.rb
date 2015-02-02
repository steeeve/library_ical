require 'icalendar'
require 'thingmaker/library_loans'

class BooksController < ApplicationController
  before_action :set_books, only: [:index]

  def index
    respond_to do |format|
      format.json { render :json => @books }
      format.ics { render :text => due_date_calendar(@books).to_ical }
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

    def due_date_calendar(books)
      # This shouldn't be in the controller
      Icalendar::Calendar.new.tap do |cal|
        books.each do |book|
          cal.event do |e|
            e.dtstart     = Icalendar::Values::Date.new(book.due_date)
            e.dtend       = Icalendar::Values::Date.new(book.due_date + 1.day)
            e.summary     = "'#{book.title}' due"
            e.ip_class    = "PRIVATE"
          end
        end

        cal.publish
      end
    end

end
