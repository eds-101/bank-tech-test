require 'bank'

describe Bank do
  describe '.balance' do
    it 'should respond to a balance method' do
      expect(subject).to respond_to(:balance)
    end
    it 'should have initial value of 0' do
      expect(subject.balance).to eq 0.00
    end

  end

  describe '.deposit' do
    it 'should respond to a deposit method' do
      expect(subject).to respond_to(:deposit).with(1).argument
    end
    it 'should increase a balance by chosen amount' do
      subject.deposit(6)
      expect(subject.balance).to eq 6
    end
  end

  describe '.credit' do
    it 'should respond to a credit method' do
      expect(subject).to respond_to(:credit).with(1).argument
    end
  end

end