require_relative './parking_man'

# Parking Boy
class ParkingBoy
  include ParkingMan
  park_strategy :find, :available?
end
