require_relative './parking_man'

# Smart Parking Boy
class SmartParkingBoy
  include ParkingMan
  park_strategy :max_by, :free_space
end
