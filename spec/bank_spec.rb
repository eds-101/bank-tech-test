require 'bank'

describe Bank do
  it 'should respond to a balance method' do
    expect(subject).to respond_to(:balance)
    # expect(subject.balance).to eq 0
  end

end