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
      before do
        subject.instance_variable_set(:@history, [
                                        { date: Date.new(2012, 1, 1), type: :deposit, amount: 20, balance: 20 },
                                        { date: Date.new(2014, 1, 1), type: :deposit, amount: 10, balance: 25 },
                                        { date: Date.new(2013, 1, 1), type: :withdraw, amount: 5, balance: 15 }
                                      ])
      end
      it 'prints transactions by descending order of date' do
        expect { subject.print_statement }.to output(
          a_string_including(
            "01/01/2014 || 10.00 || || 25.00\n"\
            "01/01/2013 || || 5.00 || 15.00\n"\
            "01/01/2012 || 20.00 || || 20.00\n"
          )
        )
          .to_stdout
      end
      it 'firstly prints out a set header column' do
        expect { subject.print_statement }.to output(
          a_string_starting_with('date || credit || debit || balance')
        )
          .to_stdout
      end
    end
  end
end
