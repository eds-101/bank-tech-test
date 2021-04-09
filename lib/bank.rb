# frozen_string_literal: true
require 'Date'

require_relative './statement_printer'

# Bank to process and store customer transactions
class Bank
  attr_reader :history

  def initialize(printer = StatementPrinter.new)
    @balance = INITIAL_BALANCE
    @history = []
    @printer = printer
  end

  def deposit(amount)
    raise 'Only input numbers!' unless number?(amount)

    @balance += amount
    record_transaction(type: :deposit, amount: amount, balance: @balance)
    @balance
  end

  def withdraw(amount)
    raise 'Only input numbers!' unless number?(amount)

    @balance -= amount
    record_transaction(type: :withdraw, amount: amount, balance: @balance)
    @balance
  end

  def print_statement
    @printer.print(@history)
  end

  def view_balance
    @history.last[:balance]
  end

  private

  INITIAL_BALANCE = 0.00

  def number?(input)
    input.is_a? Numeric
  end

  def record_transaction(type:, amount:, balance:)
    @history << { date: Date.today, type: type, amount: amount, balance: balance }
  end
end
