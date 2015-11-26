require_relative './ticket'

# Parking Boy Mixin
module ParkingBoyMixin
  # Class Methods
  module ClassMethods
    attr_reader :park_method, :park_attribute

    def park_to(method, argument)
      @park_method = method
      @park_attribute = argument
    end
  end

  # Instance Methods
  module InstanceMethods
    def initialize(*parking_lots)
      @parking_lots = parking_lots
    end

    def park(car)
      klass = self.class
      @parking_lots.send(klass.park_method, &klass.park_attribute).park(car)
    rescue
      Ticket.none
    end

    def pick(ticket)
      parking_lot = @parking_lots.find { |p| p.id == ticket.parking_lot_id }
      parking_lot.pick(ticket) if parking_lot
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end
