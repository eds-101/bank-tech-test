# frozen_string_literal: true

require 'Date'

require_relative './statement_printer'

# Bank to process and store customer transactions
class Bank
  attr_reader :history

  def initialize
    @balance = INITIAL_BALANCE
    @history = []
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

  def print_statement(statement_printer = StatementPrinter.new)
    processed_statement = statement_printer.process_statement(@history)
    statement_printer.print(processed_statement)
  end

  def view_balance
    return 0 unless @history.length > 0

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
