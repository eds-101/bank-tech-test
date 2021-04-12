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

  # describe 'storing transaction details' do
  #   before do
  #     5.times { subject.deposit(2) }
  #     2.times { subject.withdraw(3) }
  #   end
  #   it 'stores records of transactions' do
  #     expect(subject.history.length).to eq 7
  #   end
  #   it 'know what content is in the transactions' do
  #     expect(subject.history[0][:type]).to eq :deposit
  #     expect(subject.history[2][:amount]).to eq 2
  #     expect(subject.history[4][:balance]).to eq 10
  #     expect(subject.history[6][:balance]).to eq 4
  #     expect(subject.history[6][:type]).to eq :withdraw
  #   end
  # end
end
