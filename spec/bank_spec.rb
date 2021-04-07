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
  end

  describe '#withdrawal' do
    before { subject.instance_variable_set(:@balance, 10) }
    it 'responds to a withdrawal method' do
      expect(subject).to respond_to(:withdrawal).with(1).argument
    end
    it 'reduces the balance by chosen amount' do
      subject.withdrawal(6)
      expect(subject.balance).to eq 4
    end
  end

  describe '#history' do
    describe 'storing the transaction date' do
      it 'stores the transaction date' do
        allow(Date).to receive(:today).and_return Date.new(2012,1,14)
        subject.deposit(12)
        allow(Date).to receive(:today).and_return Date.today
        subject.withdrawal(4)
        expect(subject.history[0][:date]).to eq Date.new(2012,1,14)    
        expect(subject.history[1][:date]).to eq Date.today    
      end
    end
    
    describe 'storing transaction details' do
      # how to better mock transactions?
      before do
        5.times { subject.deposit(2) }
        2.times { subject.withdrawal(3) }
      end
      it 'stores records of transactions' do
        expect(subject.history.length).to eq 7      
      end
      it 'know what content is in the transactions' do
        expect(subject.history[0][:type]).to eq :deposit
        expect(subject.history[2][:amount]).to eq 2
        expect(subject.history[4][:balance]).to eq 10
        expect(subject.history[6][:balance]).to eq 4
        expect(subject.history[6][:type]).to eq :withdrawal
      end      
    end
  end

  describe '#print_statement' do
    before do
      subject.deposit(40)
      subject.withdrawal(3)
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
      withdrawal = "|| 3.00"
      expect{ subject.print_statement }.to output(
        a_string_including(deposit))
        .to_stdout
        expect{ subject.print_statement }.to output(
          a_string_including(withdrawal))
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
      withdrawal_value = date + " ||" + " || 3.00" + " || 37.00\n"
      expect{ subject.print_statement }.to output(
        a_string_ending_with(deposit_value))
        .to_stdout
      expect{ subject.print_statement }.not_to output(
        a_string_ending_with(withdrawal_value))
        .to_stdout
    end

  end

end
