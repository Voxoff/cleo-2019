class Coin
  @@all = []
  attr_accessor :quantity
  attr_reader :denomination

  def initialize(attributes = {})
    unless self.class.denominations.include?(attributes[:denomination])
      raise ArgumentError, 'Coins must be an acceptable denomination'
    end

    @denomination = attributes[:denomination]
    @quantity = attributes[:quantity]
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reload
    all.each { |coin| coin.quantity = 0 }
  end

  def self.total
    all.map { |i| i.denomination * i.quantity }.reduce(:+)
  end

  def insert
    self.quantity += 1
  end

  def release
    self.quantity -= 1
  end

  def self.find_by_denomination(denom)
    all.detect { |coin| coin.denomination == denom }
  end

  def self.denominations
    [1, 2, 5, 10, 20, 50, 100, 200]
  end

  def self.calculate_change(total_change)
    coin_hash = Hash.new(0)
    all.sort_by(&:denomination).reverse_each do |coin|
      denom = coin.denomination
      while denom <= total_change && coin.quantity > 0
        coin_hash[denom] += 1
        coin.release
        total_change -= denom
      end
    end
    coin_hash
  end
end
