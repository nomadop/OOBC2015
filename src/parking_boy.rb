require_relative './parking_man'

# Parking Boy
class ParkingBoy
  include ParkingMan
  park_to :find, :available?
end
