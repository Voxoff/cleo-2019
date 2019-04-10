require_relative '../controllers/machine_controller.rb'
require_relative '../views/view'
require_relative '../models/vending_machine'

RSpec.describe MachineController do
  change = { 1 => 2, 2 => 1, 5 => 5, 10 => 10, 20 => 3, 50 => 2, 100 => 10, 200 => 1 }
  items = { 'Nuka-Cola': 90, 'Sunset Sarsparilla': 200, 'Sierra Madre': 45, 'Bawls Guarana': 110 }
  let(:vm) { VendingMachine.new(change: change, items: items) }
  let(:controller) { MachineController.new(view: View.new, vending_machine: vm) }
  before do
    silence_output
  end

  describe '#initialize' do
    it 'must have a view and a vending machine' do
      expect(controller).to be_an_instance_of(MachineController)
    end
  end

  describe '#route_action' do
    it 'routes to reload on 999' do
      expect(controller).to receive(:reload)
      controller.route_action('999')
    end

    it 'routes to exit' do
      expect(controller).to receive(:exit)
      controller.route_action('exit')
    end

    it 'routes to select' do
      expect(controller).to receive(:select)
      controller.route_action('1')
    end
  end

  describe '#check_coin' do
    it 'checks denom of coin and either accepts or prints appropriately' do
      proc = proc { controller.instance_variable_get(:@money_inserted) }
      expect { controller.send(:check_coin, 1) }.to change { proc.call }.from(0).to(1)

      expect { controller.send(:check_coin, 99) }.not_to(change { proc.call })
    end
  end

  describe '#display_items' do
    it 'should display item' do
      controller.display_items
    end
  end

  def silence_output
    @original_stdout = $stdout
    $stdout = File.open(File::NULL, 'w')
  end
end
