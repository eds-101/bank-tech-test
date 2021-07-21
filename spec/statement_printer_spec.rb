# frozen_string_literal: true

require 'statement_printer'

describe StatementPrinter do
  before do
    @test_data = []
    allow(Date).to receive(:today).and_return Date.new(2012, 1, 14)
    @test_data << { date: Date.today, type: :deposit, amount: 40, balance: 40 }
    allow(Date).to receive(:today).and_return Date.new(2012, 1, 18)
    @test_data << { date: Date.today, type: :credit, amount: 5, balance: 35 }
  end

  it 'distinguishes between credit and debit' do
    deposit = '40.00 ||'
    withdraw = '|| 5.00'
    expect(subject.process_statement(@test_data)).to include(deposit)
    expect(subject.process_statement(@test_data)).to include(withdraw)
  end
  it 'prints transactions separated by "||" ' do
    date = Date.new(2012, 1, 14).strftime('%d/%m/%Y')
    deposit_value = "#{date} || 40.00 || || 40.00"
    expect(subject.process_statement(@test_data)).to include(deposit_value)
  end

end
