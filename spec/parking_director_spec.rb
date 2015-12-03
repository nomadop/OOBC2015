require 'rspec'
require_relative '../src/parking_lot'
require_relative '../src/parking_manager'
require_relative '../src/parking_director'

describe 'Parking Director' do
  let(:parking_lot_2_of_4) { ParkingLot.new(4).with_2_cars }
  let(:parking_lot_3_of_7) { ParkingLot.new(7).with_3_cars }

  describe 'Decorate a parking manager' do
    context 'manage a 2 of 4 parking lot' do
      it 'should report' do
        parking_manager = ParkingManager.new(parking_lot_2_of_4)
        parking_director = ParkingDirector.new(parking_manager)

        expect(parking_director.report).to eq <<-END.gsub(/^ {10}/, '')
          M 2 4
            P 2 4
        END
      end
    end

    context 'manage a 2 of 4 parking lot and manage a parking boy who manage a 3 of 7 parking lot' do
      it 'should report' do
        parking_boy = ParkingBoy.new(parking_lot_3_of_7)
        parking_manager = ParkingManager.new(parking_lot_2_of_4, parking_boy)
        parking_director = ParkingDirector.new(parking_manager)

        expect(parking_director.report).to eq <<-END.gsub(/^ {10}/, '')
          M 5 11
            P 2 4
            B 3 7
              P 3 7
        END
      end
    end
  end
end
