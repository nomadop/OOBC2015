require_relative './parking_man'

# Super Parking Boy
class SuperParkingBoy
  include ParkingMan
  park_to :max_by, :free_space_rate
end
