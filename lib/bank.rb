require 'Date'
class Bank
  attr_reader :balance, :history
  
  def initialize
    @balance = INITIAL_BALANCE
    @history = []
  end

  def deposit(amount)
    @balance += amount
    record_transaction(type: :deposit, amount: amount, balance: @balance)
    @balance
  end
  
  def withdrawal(amount)
    @balance -= amount
    record_transaction(type: :withdrawal, amount: amount, balance: @balance)
    @balance
  end

  def print_statement_header
    puts "date || credit || debit || balance"
  end

  def print_statement
    print_statement_header
    printer = ""
    process_transactions(@history.reverse, printer)
    puts printer
  end

  def process_transactions(transactions, destination_str)
    transactions.each do |record|
      date = format_date(record[:date])
      amount = format_amount(record[:type], record[:amount])
      balance = format_balance(record[:balance])
      destination_str << format_record(date, amount, balance)
    end
    destination_str
  end

  # def order_transactions_by_desc(transactions)
  #   transactions.reverse
  # end

  def format_date(date)
    date.strftime("%d/%m/%Y")
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

  def record_transaction(type:, amount:, balance:)
    @history << { date: Date.today, type: type, amount: amount, balance: balance  }
  end

  private
  INITIAL_BALANCE = 0.00

end