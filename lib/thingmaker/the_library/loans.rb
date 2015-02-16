require 'ri_cal'

module TheLibrary

  class Loans
    extend Enumerable

    def initialize(html_fragment)
      @html_fragment = html_fragment
    end

    def each
      loan_rows = html_fragment.search('tr')
      loan_rows.each do |loan_row|
        yield Loan.new(loan_row)
      end
    end

    def to_ical
      calendar.to_s
    end

    private

      def calendar
        RiCal.Calendar do |cal|
          cal.add_x_property 'x_wr_calname', 'Library Due Dates'
          each do |loan|
            cal.event do |e|
              e.dtstart     = loan.due_date
              e.summary     = "\"#{loan.title}\" is due"
            end
          end
        end
      end

  end

end
