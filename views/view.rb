class View
  def initialize
    print `clear`
    puts 'Welcome to the Nuka-Cola vending machine.'
    puts "=========================================\n\n"
  end

  def display_items(items)
    puts "\n"
    items.each_with_index do |item, index|
      puts "#{index + 1}. #{item.name} - #{to_money(item.price)}"
    end
    puts "\n"
  end

  def get_input
    print '>> '
    gets.chomp
  end

  def acceptable_denominations(denominations)
    # Ideally, would use something like to_sentence method from ActiveSupport, Rails.
    puts "This machine accepts the following denominations: #{denominations.join(', ')}"
  end

  def try_again
    print "I didn't quite get that. "
  end

  def instructions
    puts 'Please enter the code displayed to buy a drink. ' \
          'Or type 999, if you would like to change the list of items in the machine.'
  end

  def get_coin(item, change)
    puts "You've chosen #{item.name}. That'll be #{to_money(item.price)}"
    puts "Current amount entered: #{to_money(change)}"
    get_input.to_i
  end

  def dispense(change_hash, item)
    unless change_hash.empty?
      puts(change_hash.map { |denomination, quantity| "#{quantity} x #{to_money(denomination)}" })
    end
    puts "*** Serving #{item.name} ***"
  end

  def which_reload
    puts 'Press 0 to alter items or press 1 to alter the change.'
    get_input.to_i
  end

  def new_item
    puts 'Please enter the name of the new item: '
    name = get_input
    puts "And it's price: "
    price = get_input.to_i
    { name: name, price: price }
  end

  def another?(class_name)
    puts "Would you like to add another #{class_name}? (Y/N)"
    get_input.downcase.include?('y')
  end

  def new_change
    acceptable_denominations(Coin.denominations)
    puts 'Please enter one of the above denominations: '
    denomination = get_input.to_i
    puts 'Please enter the number of coins: '
    quantity = get_input.to_i
    { denomination: denomination, quantity: quantity }
  end

  private

  def to_money(money)
    "#{money}p"
  end
end
