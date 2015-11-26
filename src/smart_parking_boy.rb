require_relative './parking_boy_mixin'

# Smart Parking Boy
class SmartParkingBoy
  include ParkingBoyMixin
  park_to :max_by, :free_space
end
