require_relative '../models/vending_machine.rb'

RSpec.describe VendingMachine do

  change = { 1 => 2, 2 => 1, 5 => 5, 10 => 10, 20 => 3, 50 => 2, 100 => 10, 200 => 1 }
  items = { 'Nuka-Cola': 90, 'Sunset Sarsparilla': 200, 'Sierra Madre': 45, 'Bawls Guarana': 110 }
  let(:vending_machine) { VendingMachine.new(items: items, change: change) }

  describe '#initialize' do
    it 'cannot have blank args' do
      expect { VendingMachine.new().to raise(ArgumentError) }
    end

    it 'must be passed an hash of items and change' do
      expect { VendingMachine.new(change: [], items: '').to raise(ArgumentError) }
      expect { VendingMachine.new(change: {}, items: {}).to be_valid }
    end
  end

  describe '#current_change' do
    it 'tracks total coins' do
      # in case tests run in a different order, lets reset the coins.
      Coin.reload
      expect(vending_machine.current_change).to eq 1489
    end
  end
end
