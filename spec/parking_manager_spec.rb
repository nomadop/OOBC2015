require 'rspec'
require_relative '../src/parking_lot'
require_relative '../src/parking_manager'
require_relative '../src/parking_boy'
require_relative '../src/smart_parking_boy'

describe 'Parking Manager' do
  let(:car) { 'this_is_a_car' }
  let(:parking_lot) { ParkingLot.new }
  let(:full_parking_lot) { ParkingLot.new(1).tap { |lot| lot.park('a exist car') } }
  let(:parking_boy) { ParkingBoy.new(parking_lot) }
  let(:full_parking_boy) { ParkingBoy.new(full_parking_lot) }
  let(:smart_parking_boy) { SmartParkingBoy.new(parking_lot) }
  let(:full_smart_parking_boy) { SmartParkingBoy.new(full_parking_lot) }

  describe 'manage a parking lot only' do
    let(:parking_manager) { ParkingManager.new(parking_lot) }

    it 'should successfully park a car to parking lot' do
      ticket = parking_manager.park(car)

      expect(parking_lot.pick(ticket)).to be(car)
    end

    it 'should not successfully park a car to full parking lot' do
      parking_manager = ParkingManager.new(full_parking_lot)

      ticket = parking_manager.park(car)

      expect(parking_manager.contain?(ticket)).to be(false)
    end

    it 'should pick out the car when it is already in parking lot' do
      ticket = parking_lot.park(car)

      expect(parking_manager.pick(ticket)).to be(car)
    end

    it 'should not pick out the car when using wrong ticket' do
      parking_manager.park(car)

      expect(parking_manager.pick(Ticket.none)).to be(nil)
    end
  end

  describe 'manage a parking boy only' do
    let(:parking_manager) { ParkingManager.new(parking_boy) }

    it 'should let parking boy successfully park a car to parking lot' do
      ticket = parking_manager.park(car)

      expect(parking_boy.pick(ticket)).to be(car)
    end

    it 'should not successfully park a car when parking boy manage a full parking lot' do
      parking_manager = ParkingManager.new(full_parking_boy)

      ticket = parking_manager.park(car)

      expect(parking_manager.contain?(ticket)).to be(false)
    end

    it 'should pick out the car when it is already parked by parking boy' do
      ticket = parking_boy.park(car)

      expect(parking_manager.pick(ticket)).to be(car)
    end
  end

  describe 'manage a parking boy and a smart parking boy only' do
    it 'should let smart parking boy to park car when parking boy manage a full parking lot' do
      parking_manager = ParkingManager.new(full_parking_boy, smart_parking_boy)

      ticket = parking_manager.park(car)

      expect(smart_parking_boy.pick(ticket)).to be(car)
    end

    it 'should let parking boy to park car when smart parking boy manage a full parking lot' do
      parking_manager = ParkingManager.new(parking_boy, full_smart_parking_boy)

      ticket = parking_manager.park(car)

      expect(parking_boy.pick(ticket)).to be(car)
    end

    it 'should not successfully park car when both parking boy manage a full parking lot' do
      parking_manager = ParkingManager.new(full_parking_boy, full_smart_parking_boy)

      ticket = parking_manager.park(car)

      expect(parking_manager.contain?(ticket)).to be(false)
    end
  end
end
