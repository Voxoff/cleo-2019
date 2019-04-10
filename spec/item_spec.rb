require_relative '../models/item.rb'
RSpec.describe Item do
  before(:each) {
    Item.class_variable_set(:@@all, [])
  }

  describe '#initialize' do
    it 'creates an item' do
      expect(Item.new(name: 'Nuka-Cola', price: 1)).to be_an_instance_of(Item)
    end
  end

  describe 'Item.all' do
    it 'returns all instances in an array' do
      expect(Item.all).to be_empty
      item = Item.new(name: 'Nuka-Cola', price: 100)
      expect(Item.all).to contain_exactly(item)

      another_item = Item.new(name: 'Sunset sarsparilla', price: 200)
      expect(Item.all).to contain_exactly(item, another_item)
    end
  end

  describe 'Item.reload' do
    it 'empties @@all class variable array' do
      Item.new(name: 'Nuka-Cola', price: 100)

      Item.reload
      expect(Item.all).to be_empty
    end
  end
end
