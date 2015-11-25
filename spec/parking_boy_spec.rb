require 'rspec'
require_relative '../src/parking_lot'
require_relative '../src/parking_boy'

describe 'Parking Boy' do
  it 'should successfully park a car to parking lot' do
    parking_lot = ParkingLot.new
    parking_boy = ParkingBoy.new(parking_lot)
    car = 'this is a car'

    ticket = parking_boy.park(car)

    expect(parking_lot.pick(ticket)).to be(car)
  end

  it 'should pick out the car when it is already in parking lot' do
    parking_lot = ParkingLot.new
    parking_boy = ParkingBoy.new(parking_lot)
    car = 'this is a car'

    ticket = parking_lot.park(car)

    expect(parking_boy.pick(ticket)).to be(car)
  end

  it 'should not pick out the car when using wrong ticket' do
    car = 'this is a car'
    parking_boy = ParkingBoy.new(ParkingLot.new(1))

    parking_boy.park(car)

    expect(parking_boy.pick(Ticket.none)).to be(nil)
  end

  describe 'manage 2 parking lots' do
    it 'should park cars sequencely to two parking lots' do
      parking_lot = ParkingLot.new(0)
      another_parking_lot = ParkingLot.new(1)
      car = 'this is a car'
      parking_boy = ParkingBoy.new(parking_lot, another_parking_lot)

      ticket = parking_boy.park(car)

      expect(another_parking_lot.pick(ticket)).to be(car)
    end

    it 'should not park cars when two parking lots is full' do
      parking_lot = ParkingLot.new(0)
      another_parking_lot = ParkingLot.new(0)
      car = 'this is a car'
      parking_boy = ParkingBoy.new(parking_lot, another_parking_lot)

      ticket = parking_boy.park(car)

      expect(ticket.success).to be(false)
    end
  end
end
