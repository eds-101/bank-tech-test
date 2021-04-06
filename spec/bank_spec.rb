require 'bank'

describe Bank do
  describe '#balance' do
    it 'should respond to a balance method' do
      expect(subject).to respond_to(:balance)
    end
    it 'should have initial value of 0' do
      expect(subject.balance).to eq 0.00
    end
  end

  describe '#deposit' do
    it 'should respond to a deposit method' do
      expect(subject).to respond_to(:deposit).with(1).argument
    end
    it 'should increase a balance by chosen amount' do
      subject.deposit(6)
      expect(subject.balance).to eq 6
    end
  end

  describe '#credit' do
    before { subject.instance_variable_set(:@balance, 10) }
    it 'should respond to a credit method' do
      expect(subject).to respond_to(:credit).with(1).argument
    end
    it 'should reduce the balance by chosen amount' do
      subject.credit(6)
      expect(subject.balance).to eq 4
    end
  end

  describe '#history' do
    # how to better mock transactions?
    before do
      5.times { subject.deposit(2) }
    end
    it 'should store records of transactions' do
      expect(subject.history.length).to eq 5      
    end
    it 'should store records of transactions' do
      expect(subject.history[0][:type]).to eq :deposit
    end      
  end

end