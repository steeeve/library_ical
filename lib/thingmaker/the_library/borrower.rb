require 'mechanize'

module TheLibrary

  class Borrower

    def initialize(borrower_number)
      @agent = Mechanize.new

      login(borrower_number)
    end

    def login(borrower_number)
      @agent.get('https://capitadiscovery.co.uk/cornwall/login') do |login_page|
        login_page.form_with(:id => 'borrowerServices') do |login_form|
          login_form.barcode = borrower_number
        end.submit
      end
    end

    def loans
      safe_letters = /[^A-Za-z0-9\:\-\ ]+/

      Loans.new.tap do |loans|
        @agent.get('https://capitadiscovery.co.uk/cornwall/account') do |account_page|
          loan_rows = account_page.search('#loans tbody tr')

          loan_rows.each do |loan|
            title = loan.search('.loanItemLink').text.gsub(safe_letters, '')
            author = loan.search('.author').text.gsub(safe_letters, '')
            due_date = Date.parse(loan.search('.accDue').text.gsub(safe_letters, ''))
            loans.add Loan.new(title, author, due_date)
          end
        end
      end
    end

  end
end
