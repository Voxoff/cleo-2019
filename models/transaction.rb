class Transaction
  @@all = []
  attr_reader :coins, :item
  def initialize(attr = {})
    @item = attr[:item]
    @coins = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.three_most_popular
    require 'pry'; binding.pry
    all.group_by(&:item).max_by(3) { |_, v| v.count }
  end
end
