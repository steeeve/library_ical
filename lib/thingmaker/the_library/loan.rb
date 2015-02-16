module TheLibrary

  class Loan

    def initialize(html_fragment)
      @html_fragment = html_fragment
    end

    def title
      sanitize_text_node(@html_fragment.search('.loanItemLink').text)
    end

    def author
      sanitize_text_node(@html_fragment.search('.author').text)
    end

    def due_date
      Date.parse(sanitize_text_node(@html_fragment.search('.accDue').text))
    end

    private

      def sanitize_text_node(text)
        safe_letters = /[^A-Za-z0-9\'\,\:\-\ ]+/
        text.gsub(safe_letters, '').strip
      end

  end

end
