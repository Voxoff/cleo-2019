require_relative './models/coin'
require_relative './models/item'
require_relative './models/vending_machine'
require_relative './controllers/machine_controller'
require_relative './views/view'

change = { 1 => 2, 2 => 1, 5 => 5, 10 => 10, 20 => 3, 50 => 2, 100 => 10, 200 => 1 }
items = { 'Nuka-Cola': 90, 'Sunset Sarsparilla': 200, 'Sierra Madre': 45, 'Bawls Guarana': 110 }

view = View.new
vm = VendingMachine.new(items: items, change: change)

@controller = MachineController.new(view: view, vending_machine: vm)
@controller.turn_on
