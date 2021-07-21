require 'bank'

describe 'Acceptance test' do

  it "allows a user to make bank transactions and print a statement" do
    bank = Bank.new
    allow(Date).to receive(:today).and_return Date.new(2012, 1, 10)
    bank.deposit(1000)
    allow(Date).to receive(:today).and_return Date.new(2012, 1, 13)
    bank.deposit(2000)
    allow(Date).to receive(:today).and_return Date.new(2012, 1, 14)
    bank.withdraw(500)
    bank.print_statement
    expect { bank.print_statement }.to output(
      a_string_including(
        "date || credit || debit || balance\n"\
        "14/01/2012 || || 500.00 || 2500.00\n"\
        "13/01/2012 || 2000.00 || || 3000.00\n"\
        "10/01/2012 || 1000.00 || || 1000.00\n"
      )
    )
      .to_stdout
  end

end
