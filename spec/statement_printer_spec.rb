# frozen_string_literal: true

require 'statement_printer'
require 'bank'

describe StatementPrinter do
  before do
    @bank = Bank.new
    @bank.deposit(40)
    @bank.withdraw(5)
  end

  it 'distinguishes between credit and debit' do
    deposit = '40.00 ||'
    withdraw = '|| 5.00'
    expect(subject.process(@bank.history)).to include(deposit)
    expect(subject.process(@bank.history)).to include(withdraw)
  end
  it 'prints transactions separated by "||" ' do
    date = Date.today.strftime('%d/%m/%Y')
    deposit_value = "#{date} || 40.00 || || 40.00"
    expect(subject.process(@bank.history)).to include(deposit_value)
  end
  it 'orders transactions by date, descending' do
    date = Date.today.strftime('%d/%m/%Y')
    deposit_value = "#{date} || 40.00 || || 40.00\n"
    withdraw_value = "#{date} || || 5.00 || 35.00"
    expect(subject.process(@bank.history)).to start_with(withdraw_value)
    expect(subject.process(@bank.history)).to end_with(deposit_value)
  end
  
  it 'prints out a set header column' do
    expect { subject.print(@bank.history) }.to output(
      a_string_starting_with('date || credit || debit || balance')
    )
      .to_stdout
  end
end