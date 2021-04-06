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
  
  def credit(amount)
    @balance -= amount
    record_transaction(type: :credit, amount: amount, balance: @balance)
    @balance
  end

  def print_statement
    "date || credit || debit || balance"
  end

  def record_transaction(type:, amount:, balance:)
    @history << { date: Date.today, type: type, amount: amount, balance: balance  }
  end

end