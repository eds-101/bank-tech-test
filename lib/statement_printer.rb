# Processor to prepare bank history for printing
class StatementPrinter

  def process_statement(transactions)
    transactions_ordered = order_transactions_by_desc(transactions)
    format_transactions(transactions_ordered)
  end

  def print(statement)
    print_statement_header
    puts statement
  end

  private

  def format_transactions(transactions)
    output = ''
    transactions.each do |record|
      date = format_date(record[:date])
      amount = format_amount(record[:type], record[:amount])
      balance = format_balance(record[:balance])
      output << format_record(date, amount, balance)
    end
    output
  end

  def print_statement_header
    puts 'date || credit || debit || balance'
  end

  def format_date(date)
    date.strftime('%d/%m/%Y')
  end

  def format_amount(type, amount)
    type == :deposit ? '%0.2f ||' % amount : '|| %0.2f' % amount
  end

  def format_balance(balance)
    '%0.2f' % balance
  end

  def format_record(date, amount, balance)
    "#{date} || #{amount} || #{balance}" + "\n"
  end

  def order_transactions_by_desc(transactions)
    transactions.reverse
  end
end
