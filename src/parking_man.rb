require_relative './ticket'
require_relative './reportable'

# Parking Man
module ParkingMan
  # Class Methods
  module ClassMethods
    attr_reader :park_method, :park_attribute, :acceptance_container_types, :capital

    def park_strategy(method, attribute)
      @park_method = method
      @park_attribute = attribute
    end

    def acceptance_containers(*klasses)
      @acceptance_container_types = klasses << 'ParkingLot'
    end

    def define_capital(capital)
      @capital = capital
    end
  end

  # Instance Methods
  module InstanceMethods
    attr_reader :containers

    def initialize(*containers)
      containers.map(&:class).uniq do |k|
        fail "unacceptance container #{k}" unless klass.acceptance_container_types.include?(k.to_s)
      end
      @containers = containers
    end

    def park(car)
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

    def parked_count
      @containers.map(&:parked_count).reduce(:+)
    end

    def capacity
      @containers.map(&:capacity).reduce(:+)
    end

    private

    def klass
      self.class
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
    receiver.send :include, Reportable
    receiver.send :acceptance_containers
  end
end
