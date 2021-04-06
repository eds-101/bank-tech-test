require 'bank'

describe Bank do
  it 'should return a balance' do
    expect(subject.balance).to eq 0
  end

end