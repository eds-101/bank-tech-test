class Bank
  attr_reader :balance, :history
  
  INITIAL_BALANCE = 0.00

  def initialize
    @balance = INITIAL_BALANCE
    @history = []
  end

  def deposit(amount)
    @balance += amount
    @history << 1
  end
  
  def credit(amount)
    @balance -= amount
  end

end