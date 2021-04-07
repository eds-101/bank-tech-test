require 'Date'
class Bank
  attr_reader :balance, :history
  
  def initialize
    @balance = INITIAL_BALANCE
    @history = []
  end

  def deposit(amount)
    raise "Only input numbers!" unless number?(amount)
    @balance += amount
    record_transaction(type: :deposit, amount: amount, balance: @balance)
    @balance
  end
  
  def withdraw(amount)
    raise "Only input numbers!" unless number?(amount)
    @balance -= amount
    record_transaction(type: :withdraw, amount: amount, balance: @balance)
    @balance
  end

  
  private
    INITIAL_BALANCE = 0.00
    
    def number?(input)
      input.is_a? Numeric
    end

    def record_transaction(type:, amount:, balance:)
      @history << { date: Date.today, type: type, amount: amount, balance: balance  }
    end

end