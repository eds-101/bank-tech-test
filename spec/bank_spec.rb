require 'bank'

describe Bank do
  describe '.balance' do
    it 'should respond to a balance method' do
      expect(subject).to respond_to(:balance)
    end
    it 'should have initial value of 0' do
      expect(subject.balance).to eq 0
    end

  end

end