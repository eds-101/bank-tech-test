require 'Date'
class Bank
  attr_reader :balance, :history
  
  INITIAL_BALANCE = 0.00

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
    @history.each do |record|
      date = record[:date].strftime("%d/%m/%Y")
      amount = '%0.2f' % record[:amount]
      balance = '%0.2f' % record[:balance]
      printer << "#{date} #{amount} #{balance}" + "\n"
    end
    puts printer
  end

  def record_transaction(type:, amount:, balance:)
    @history << { date: Date.today, type: type, amount: amount, balance: balance  }
  end

end