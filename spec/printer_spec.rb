require 'printer'
require 'bank'
require 'Date'

describe Printer do
  describe '#print_statement' do
    # before do
    #   subject.deposit(40)
    #   subject.withdraw(3)
    # end
    it 'prints out a set header column' do
      expect{ subject.print_statement }.to output(
        a_string_starting_with("date || credit || debit || balance"))
        .to_stdout
    end

  end

end