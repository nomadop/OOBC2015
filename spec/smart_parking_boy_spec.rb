require 'rspec'
require_relative '../src/parking_lot'
require_relative '../src/smart_parking_boy'

describe 'Smart Parking Boy' do
  it 'should successfully park a car to parking lot' do
    parking_lot = ParkingLot.new
    smart_parking_boy = SmartParkingBoy.new(parking_lot)
    car = 'this is a car'

    ticket = smart_parking_boy.park(car)

    expect(parking_lot.pick(ticket)).to be(car)
  end

  it 'should pick out the car when it is already in parking lot' do
    parking_lot = ParkingLot.new
    smart_parking_boy = SmartParkingBoy.new(parking_lot)
    car = 'this is a car'

    ticket = parking_lot.park(car)

    expect(smart_parking_boy.pick(ticket)).to be(car)
  end

  it 'should not pick out the car when using wrong ticket' do
    car = 'this is a car'
    smart_parking_boy = SmartParkingBoy.new(ParkingLot.new(1))

    smart_parking_boy.park(car)

    expect(smart_parking_boy.pick(Ticket.none)).to be(nil)
  end

  describe 'manage 2 parking lots' do
    it 'should park the car to parking lot having more free space when two parking lots have different free space' do
      less_free_space_lot = ParkingLot.new(2).tap{ |lot| lot.park('a exist car') }
      more_free_space_lot = ParkingLot.new(2)
      smart_parking_boy = SmartParkingBoy.new(less_free_space_lot, more_free_space_lot)
      car = 'this is a car'

      ticket = smart_parking_boy.park(car)

      expect(more_free_space_lot.pick(ticket)).to be(car)
    end

    it 'should park the car successfully when two parking lots have same free space' do
      parking_lot = ParkingLot.new(2)
      another_parking_lot = ParkingLot.new(2)
      smart_parking_boy = SmartParkingBoy.new(parking_lot, another_parking_lot)
      car = 'this is a car'

      ticket = smart_parking_boy.park(car)

      expect(smart_parking_boy.pick(ticket)).to be(car)
    end
  end
end
