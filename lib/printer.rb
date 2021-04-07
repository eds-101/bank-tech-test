class Printer

  def print(file)
    print_statement_header
    puts file
  end

  private
    def print_statement_header
      puts "date || credit || debit || balance"
    end

end