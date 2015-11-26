require_relative './parking_boy_mixin'

# Super Parking Boy
class SuperParkingBoy
  include ParkingBoyMixin
  park_to :max_by, :free_space_rate
end
