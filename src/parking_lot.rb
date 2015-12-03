require_relative './ticket'
require_relative './reportable'

# Parking Lot
class ParkingLot
  include Reportable
  define_capital :P

  attr_reader :free_space

  def initialize(free_space = Float::INFINITY)
    @free_space = free_space
    @lots = {}
  end

  def park(car)
    if available?
      Ticket.new.tap do |ticket|
        @free_space -= 1
        @lots[ticket.token] = car
      end
    else
      Ticket.none
    end
  end

  def pick(ticket)
    @free_space += 1
    @lots.delete(ticket.token)
  end

  def contain?(ticket)
    @lots.keys.include?(ticket.token)
  end

  def available?
    @free_space > 0
  end

  def free_space_rate
    free_space * 1.0 / capacity
  end

  def capacity
    parked_count + @free_space
  end

  def parked_count
    @lots.size
  end
end
