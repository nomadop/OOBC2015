require_relative './parking_boy_mixin'

# Parking Boy
class ParkingBoy
  include ParkingBoyMixin
  park_to :find, :available?
end
