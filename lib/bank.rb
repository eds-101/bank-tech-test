class Bank
  attr_reader :balance, :history
  
  INITIAL_BALANCE = 0.00

  def initialize
    @balance = INITIAL_BALANCE
    @history = []
  end

  def deposit(amount)
    @balance += amount
    @history << { date: Date.today, type: :deposit, amount: amount, balance: @balance  }
  end
  
  def credit(amount)
    @balance -= amount
    @history << { date: Date.today, type: :credit, amount: amount, balance: @balance  }
  end

end