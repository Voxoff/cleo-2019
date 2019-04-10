require_relative '../models/coin'

RSpec.describe Coin do
  before(:each) {
    Coin.class_variable_set(:@@all, [])
  }

  let(:coin) { Coin.new(denomination: 100, quantity: 10)}

  describe '#initialize' do
    it 'will raise argument error if denomination is not valid' do
      expect { Coin.new(denomination: 99, quantity: 10) }.to raise_error(ArgumentError)
    end
  end

  describe '#insert' do
    it 'increases quantity by 1' do
      expect { coin.insert }.to change { coin.quantity }.from(10).to(11)
    end
  end

  describe '#release' do
    it 'decreaases quantity by 1' do
      expect { coin.release }.to change { coin.quantity }.from(10).to(9)
    end
  end

  describe 'Coin.all' do
    it 'stores previous new coins in class variable' do
      coin = Coin.new(denomination: 1, quantity: 10)
      expect(Coin.all).to eq([coin])
    end
  end

  describe 'Coin.reload' do
    it 'empties all class variable on reload' do
      Coin.new(denomination: 1, quantity: 10)
      Coin.new(denomination: 100, quantity: 10)
      Coin.reload
      expect(Coin.all.map(&:quantity)).to eq([0, 0])
    end
  end

  describe 'Coin.denominations' do
    it 'returns the acceptable denominations' do
      expect(Coin.denominations).to eq([1, 2, 5, 10, 20, 50, 100, 200])
    end
  end

  describe 'Coin.total' do
    it 'calculates total' do
      Coin.new(denomination: 1, quantity: 10)
      Coin.new(denomination: 100, quantity: 10)
      expect(Coin.total).to eq(1010)
    end
  end

  describe 'Coin.calculate_change' do
    it 'calculates change to return to user using available coins only' do
      Coin.new(denomination: 1, quantity: 15)
      Coin.new(denomination: 5, quantity: 15)
      Coin.new(denomination: 10, quantity: 15)
      Coin.new(denomination: 100, quantity: 1)
      change = Coin.calculate_change(105)
      expect(change).to eq ({100=>1, 5=>1})

      change = Coin.calculate_change(105)
      expect(change).to eq ({10=>10, 5=>1})
    end
  end
end
