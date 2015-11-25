require 'rspec'
require_relative '../src/parking_lot'
require_relative '../src/super_parking_boy'

describe 'Super Parking Boy' do
  it 'should successfully park a car to parking lot' do
    parking_lot = ParkingLot.new
    super_parking_boy = SuperParkingBoy.new(parking_lot)
    car = 'this is a car'

    ticket = super_parking_boy.park(car)

    expect(parking_lot.pick(ticket)).to be(car)
  end

  it 'should pick out the car when it is already in parking lot' do
    parking_lot = ParkingLot.new
    super_parking_boy = SuperParkingBoy.new(parking_lot)
    car = 'this is a car'

    ticket = parking_lot.park(car)

    expect(super_parking_boy.pick(ticket)).to be(car)
  end

  it 'should not pick out the car when using wrong ticket' do
    car = 'this is a car'
    super_parking_boy = SuperParkingBoy.new(ParkingLot.new(1))

    super_parking_boy.park(car)

    expect(super_parking_boy.pick(Ticket.none)).to be(nil)
  end

  describe 'manage 2 parking lots' do
    it 'should park the car to parking lot having more free space rate when two parking lots have different free space rate' do
      less_free_space_rate_lot = ParkingLot.new(2).tap { |lot| lot.park('a exist car') }
      more_free_space_rate_lot = ParkingLot.new(3).tap { |lot| lot.park('a exist car') }
      super_parking_boy = SuperParkingBoy.new(less_free_space_rate_lot, more_free_space_rate_lot)
      car = 'this is a car'

      ticket = super_parking_boy.park(car)

      expect(more_free_space_rate_lot.pick(ticket)).to be(car)
    end

    it 'should park the car successfully when two parking lots have same free space rate' do
      parking_lot = ParkingLot.new(2).tap { |lot| lot.park('a exist car') }
      another_parking_lot = ParkingLot.new(4).tap do |lot|
        2.times { |i| lot.park("exist car #{i}") }
      end
      super_parking_boy = SuperParkingBoy.new(parking_lot, another_parking_lot)
      car = 'this is a car'

      ticket = super_parking_boy.park(car)

      expect(super_parking_boy.pick(ticket)).to be(car)
    end
  end
end
