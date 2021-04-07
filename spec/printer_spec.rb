require 'printer'
require 'bank'
require 'Date'

describe Printer do
  describe '#print_statement' do
    before do
      subject.deposit(40)
      subject.withdraw(3)
    end
    it 'prints out a set header column' do
      expect{ subject.print_statement }.to output(
        a_string_starting_with("date || credit || debit || balance"))
        .to_stdout
    end
      # dont know how to test the order of the output or the 
      # number of entries
    it 'distinguishes between credit and debit' do
      deposit = "40.00 ||"
      withdraw = "|| 3.00"
      expect{ subject.print_statement }.to output(
        a_string_including(deposit))
        .to_stdout
        expect{ subject.print_statement }.to output(
          a_string_including(withdraw))
          .to_stdout
    end
    it 'prints transactions separated by "||" ' do
      date = Date.today.strftime("%d/%m/%Y")
      deposit_value = date + " || 40.00 ||" + " || 40.00"
      expect{ subject.print_statement }.to output(
        a_string_including(deposit_value))
        .to_stdout
    end

    it 'orders transactions by date, descending' do
      date = Date.today.strftime("%d/%m/%Y")
      deposit_value = date + " ||" + " 40.00 ||" + " || 40.00\n"
      withdraw_value = date + " ||" + " || 3.00" + " || 37.00\n"
      expect{ subject.print_statement }.to output(
        a_string_ending_with(deposit_value))
        .to_stdout
      expect{ subject.print_statement }.not_to output(
        a_string_ending_with(withdraw_value))
        .to_stdout
    end
  end

end