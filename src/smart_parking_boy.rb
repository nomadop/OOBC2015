require_relative './parking_boy_mixin'
require_relative './parking_lot'

# Smart Parking Boy
class SmartParkingBoy
  include ParkingBoyMixin

  def park(car)
    @parking_lots.max_by(&:free_space).park(car)
  end
end