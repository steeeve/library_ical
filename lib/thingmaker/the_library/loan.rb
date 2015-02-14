module TheLibrary

  class Loan < Struct.new('Loan', :title, :author, :due_date)
  end

end
