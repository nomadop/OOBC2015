require_relative './ticket'

# Parking Man
module ParkingMan
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
    def initialize(*containers)
      @containers = containers
    end

    def park(car)
      klass = self.class
      @containers.send(klass.park_method, &klass.park_attribute).park(car)
    rescue
      Ticket.none
    end

    def pick(ticket)
      parking_lot = @containers.find { |lot| lot.contain?(ticket) }
      parking_lot.pick(ticket) if parking_lot
    end

    def contain?(ticket)
      @containers.any? { |lot| lot.contain?(ticket) }
    end

    def available?
      @containers.any?(&:available?)
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end
