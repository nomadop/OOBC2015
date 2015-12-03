require_relative './parking_man'

# Super Parking Boy
class SuperParkingBoy
  include ParkingMan
  park_strategy :max_by, :free_space_rate
  define_capital :B
end
