require 'printer'
require 'bank'
require 'processor'

require 'Date'

describe Printer do
  before do
    bank = Bank.new
    bank.deposit(40)
    bank.withdraw(5)
    processor = Processor.new
    @history = processor.process(bank.history)
  end

  describe '#print' do
    it 'prints out a set header column' do
      expect{ subject.print(@history) }.to output(
        a_string_starting_with("date || credit || debit || balance"))
        .to_stdout
    end
  end

end

