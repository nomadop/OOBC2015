require_relative './parking_man'

# Parking Manager
class ParkingManager
  include ParkingMan
  park_strategy :find, :available?
  acceptance_containers 'ParkingBoy', 'SmartParkingBoy', 'SuperParkingBoy'
  define_capital :M
end
