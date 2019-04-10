class Item
  @@all = []
  attr_reader :name, :price
  def initialize(attributes = {})
    @name = attributes[:name]
    @price = attributes[:price]
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reload
    @@all = []
  end
end
