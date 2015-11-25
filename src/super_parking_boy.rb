require_relative './parking_boy_mixin'
require_relative './parking_lot'

# Super Parking Boy
class SuperParkingBoy
  include ParkingBoyMixin

  def park(car)
    @parking_lots.max_by(&:free_space_rate).park(car)
  end
end