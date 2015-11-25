require_relative './parking_boy_mixin'
require_relative './parking_lot'

# Parking Boy
class ParkingBoy
  include ParkingBoyMixin

  def park(car)
    @parking_lots.find(&:available?).park(car)
  rescue => e
    Ticket.none
  end
end
