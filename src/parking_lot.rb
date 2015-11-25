require 'securerandom'
require_relative './ticket'

# Parking Lot
class ParkingLot
  attr_accessor :id, :free_space

  def initialize(free_space = Float::INFINITY)
    @free_space = free_space
    @lots = {}
    @id = SecureRandom.uuid
  end

  def park(car)
    if available?
      Ticket.new(@id).tap do |ticket|
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

  def available?
    @free_space > 0
  end

  def free_space_rate
    free_space * 1.0 / capacity
  end

  private

  def capacity
    @lots.size + @free_space
  end
end
