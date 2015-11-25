# Parking Boy Mixin
module ParkingBoyMixin
  # Instance Methods
  module InstanceMethods
    def initialize(*parking_lots)
      @parking_lots = parking_lots
    end

    def pick(ticket)
      parking_lot = @parking_lots.find { |p| p.id == ticket.parking_lot_id }
      parking_lot.pick(ticket) if parking_lot
    end
  end

  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end
