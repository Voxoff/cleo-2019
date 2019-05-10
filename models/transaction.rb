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
    all.group_by(&:item).max_by(3) { |_, v| v.count }
    all.max_by {|t| t.item.count}
  end
end
