# frozen_string_literal: true

require 'bank'
require 'Date'

describe Bank do
  describe '#balance' do
    it 'responds to a balance method' do
      expect(subject).to respond_to(:balance)
    end
    it 'has an initial value of 0' do
      expect(subject.balance).to eq 0.00
    end
  end

  describe '#deposit' do
    it 'responds to a deposit method' do
      expect(subject).to respond_to(:deposit).with(1).argument
    end
    it 'increases a balance by chosen amount' do
      subject.deposit(6)
      expect(subject.balance).to eq 6
    end
    it 'only takes numbers to be entered for deposits' do
      expect { subject.deposit('10k') }.to raise_error 'Only input numbers!'
    end
  end

  describe '#withdraw' do
    before { subject.instance_variable_set(:@balance, 10) }
    it 'responds to a withdraw method' do
      expect(subject).to respond_to(:withdraw).with(1).argument
    end
    it 'reduces the balance by chosen amount' do
      subject.withdraw(6)
      expect(subject.balance).to eq 4
    end
    it 'only takes numbers to be entered for withdraw' do
      expect { subject.withdraw('$1m') }.to raise_error 'Only input numbers!'
    end
  end

  describe '#history' do
    describe 'storing the transaction date' do
      it 'stores the transaction date' do
        allow(Date).to receive(:today).and_return Date.new(2012, 1, 14)
        subject.deposit(12)
        allow(Date).to receive(:today).and_return Date.today
        subject.withdraw(4)
        expect(subject.history[0][:date]).to eq Date.new(2012, 1, 14)
        expect(subject.history[1][:date]).to eq Date.today
      end
    end

    describe 'storing transaction details' do
      # how to better mock transactions?
      before do
        5.times { subject.deposit(2) }
        2.times { subject.withdraw(3) }
      end
      it 'stores records of transactions' do
        expect(subject.history.length).to eq 7
      end
      it 'know what content is in the transactions' do
        expect(subject.history[0][:type]).to eq :deposit
        expect(subject.history[2][:amount]).to eq 2
        expect(subject.history[4][:balance]).to eq 10
        expect(subject.history[6][:balance]).to eq 4
        expect(subject.history[6][:type]).to eq :withdraw
      end
    end
  end
end
