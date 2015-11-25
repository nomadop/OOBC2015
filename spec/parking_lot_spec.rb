require 'rspec'
require_relative '../src/parking_lot'
require_relative '../src/ticket'

describe 'Parking Lot' do
  describe 'with infinity capacity' do
    describe 'parking one car' do
      before(:each) do
        @parking_lot = ParkingLot.new
        @car = 'this is a car'
        @ticket = @parking_lot.park(@car)
      end

      it 'should get the car back when pick with right ticket' do
        expect(@parking_lot.pick(@ticket)).to be(@car)
      end

      it 'should not get the car back when pick with wrong ticket' do
        expect(@parking_lot.pick(Ticket.new)).not_to be(@car)
      end

      it 'should not get the car back when pick with right ticket twice' do
        @parking_lot.pick(@ticket)

        expect(@parking_lot.pick(@ticket)).not_to be(@car)
      end
    end
  end

  describe 'with 2 capacity' do
    describe 'parking multiple cars' do
      before(:each) do
        @parking_lot = ParkingLot.new(2)
      end

      it 'should successfully park 2 cars' do
        car = 'this is a car'
        another_car = 'this is another car'

        ticket = @parking_lot.park(car)
        another_ticket = @parking_lot.park(another_car)

        expect(@parking_lot.pick(ticket)).to be(car)
        expect(@parking_lot.pick(another_ticket)).to be(another_car)
      end

      it 'should not successfully park 3rd car' do
        @parking_lot.park('1st car')
        @parking_lot.park('2nd car')
        ticket = @parking_lot.park('3rd car')

        expect(ticket.success).to be(false)
      end
    end
  end

  describe 'with no capacity' do
    before(:each) do
      @parking_lot = ParkingLot.new(0)
    end

    it 'should not park car' do
      ticket = @parking_lot.park('this is a car')

      expect(ticket.success).to be(false)
    end
  end
end
