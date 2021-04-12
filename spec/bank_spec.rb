# frozen_string_literal: true

require 'bank'
require 'statement_printer'
require 'Date'

describe Bank do
  describe '#balance' do
    it 'has an initial value of 0' do
      expect(subject.view_balance).to eq 0
    end
  end

  describe '#deposit' do
    it 'increases a balance by chosen amount' do
      subject.deposit(6)
      expect(subject.view_balance).to eq 6
    end
    it 'only takes numbers to be entered for deposits' do
      expect { subject.deposit('10k') }.to raise_error 'Only input numbers!'
    end
  end

  describe '#withdraw' do
    before { subject.instance_variable_set(:@balance, 10) }
    it 'reduces the balance by chosen amount' do
      subject.withdraw(6)
      expect(subject.view_balance).to eq 4
    end
    it 'only takes numbers to be entered for withdraw' do
      expect { subject.withdraw('$1m') }.to raise_error 'Only input numbers!'
    end
  end

  describe '#view_balance' do
    describe 'with transactions completed' do
      before { subject.instance_variable_set(:@history, [
        { date: Date.new(2012, 1, 1), type: :deposit, amount: 20, balance: 20 },
        { date: Date.new(2014, 1, 1), type: :deposit, amount: 10, balance: 25 },      
        { date: Date.new(2013, 1, 1), type: :withdraw, amount: 5, balance: 15 }      
      ]) }
      it 'prints transactions by descending order of date' do
          # expect, string output?
      end
      it 'firstly prints out a set header column' do
        expect { subject.print_statement }.to output(
          a_string_starting_with('date || credit || debit || balance')
        )
          .to_stdout
      end
    end

    # describe 'storing the transaction date' do
    #   it 'stores the transaction date' do
    #     allow(Date).to receive(:today).and_return Date.new(2012, 1, 14)
    #     subject.deposit(12)
    #     allow(Date).to receive(:today).and_return Date.today
    #     subject.withdraw(4)
    #     expect(subject.history[0][:date]).to eq Date.new(2012, 1, 14)
    #     expect(subject.history[1][:date]).to eq Date.today
    #   end
    # end

  end

  # it 'orders transactions by date, descending' do
  #   date = Date.today.strftime('%d/%m/%Y')
  #   deposit_value = "#{date} || 40.00 || || 40.00\n"
  #   withdraw_value = "#{date} || || 5.00 || 35.00"
  #   expect(subject.process(@bank.history)).to start_with(withdraw_value)
  #   expect(subject.process(@bank.history)).to end_with(deposit_value)
  # end


end
