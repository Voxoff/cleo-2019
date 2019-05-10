class MachineController
  def initialize(attributes = {})
    @view = attributes[:view]
    @vending_machine = attributes[:vending_machine]
    @online = true
    @money_inserted = 0
  end

  def turn_on
    while @online
      display_items
      @view.instructions
      action = @view.get_input
      route_action(action)
    end
  end

  def route_action(action)
    if action.to_i.between?(1, Item.all.size)
      select(action.to_i)
    elsif action.to_i == 999
      reload
    elsif action.casecmp('exit').zero?
      exit
    else
      @view.try_again
    end
  end

  def exit
    @online = false
  end

  def display_items
    items = @vending_machine.current_items
    @view.display_items(items)
  end

  def select(input)
    selected_item = Item.all[input - 1]
    @transaction = Transaction.new(item: selected_item)
    insert_change = wait_for_coin(selected_item)
    return_change = Coin.calculate_change(insert_change - selected_item.price)
    @view.dispense(return_change, selected_item)
    @money_inserted = 0
  end

  private

  def wait_for_coin(item)
    while @money_inserted <= item.price
      coin = @view.get_coin(item, @money_inserted)
      check_coin(coin)
    end
    @money_inserted
  end

  def check_coin(coin)
    denominations = Coin.denominations
    if denominations.any?(coin)
      @money_inserted += coin
      Coin.find_by_denomination(coin).insert
      @transaction.coins << coin
    else
      @view.try_again
      @view.acceptable_denominations(denominations)
    end
  end

  def reload
    item_or_change = @view.which_reload
    if item_or_change.zero?
      Item.reload
      Item.new(@view.new_item)
      Item.new(@view.new_item) while @view.another?('item')
    else
      Coin.reload
      Coin.new(@view.new_change)
      Coin.new(@view.new_change) while @view.another?('coin')
    end
  end
end
