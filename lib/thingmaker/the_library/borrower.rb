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
      @agent.get('https://capitadiscovery.co.uk/cornwall/account') do |account_page|
        Loans.new(account_page.search('#loans'))
      end
    end

  end
end
