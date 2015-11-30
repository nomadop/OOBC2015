require_relative './parking_man'

# Parking Manager
class ParkingManager
  include ParkingMan
  park_to :find, :available?
end
