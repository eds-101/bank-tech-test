class Bank
  attr_reader :balance
  
  INITIAL_BALANCE = 0.00

  def initialize
    @balance = INITIAL_BALANCE
  end

  def deposit(amount)
    @balance += amount
  end

  def credit(amount)
  end


end