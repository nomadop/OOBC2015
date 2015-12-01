require_relative './ticket'

# Parking Man
module ParkingMan
  # Class Methods
  module ClassMethods
    attr_reader :park_method, :park_attribute

    def park_to(method, attribute)
      @park_method = method
      @park_attribute = attribute
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
    rescue NoMethodError
      Ticket.none
    end

    def pick(ticket)
      container = @containers.find { |c| c.contain?(ticket) }
      container.pick(ticket) if container
    end

    def contain?(ticket)
      @containers.any? { |c| c.contain?(ticket) }
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
