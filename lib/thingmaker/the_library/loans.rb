require 'ri_cal'
require 'forwardable'

module TheLibrary

  class Loans
    extend Forwardable
    def_delegators :@loans, :<<, :size

    def initialize
      @loans = []
    end

    def calendar
      RiCal.Calendar do |cal|
        cal.add_x_property 'x_wr_calname', 'Library Due Dates'
        @loans.each do |loan|
          cal.event do |e|
            e.dtstart     = loan.due_date
            e.summary     = "\"#{loan.title}\" is due"
          end
        end
      end
    end

    def to_ical
      calendar.to_s
    end

  end

end
