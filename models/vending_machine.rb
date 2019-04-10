require_relative 'coin'
require_relative 'item'

class VendingMachine
  def initialize(attributes = {})
    raise ArgumentError, 'A vending machine must have change hash' unless attributes[:change].is_a?(Hash)
    raise ArgumentError, 'A vending machine must have items hash' unless attributes[:items].is_a?(Hash)

    @items = attributes[:items].each { |name, price| Item.new(name: name, price: price) }
    @coins = attributes[:change].each do |denom, qty|
      Coin.new(denomination: denom, quantity: qty)
    end
  end

  def reload(attributes)
    @items = attributes[:item]
    @change = attributes[:change]
  end

  def current_change
    Coin.total
  end

  def current_items
    Item.all
  end
end
