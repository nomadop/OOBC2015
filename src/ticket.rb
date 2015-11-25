require 'securerandom'

# Ticket
class Ticket
  attr_accessor :parking_lot_id, :token, :success

  class << self
    def none
      new(nil)
    end
  end

  def initialize(parking_lot_id = nil)
    @parking_lot_id = parking_lot_id
    if parking_lot_id
      @token = SecureRandom.hex(64)
      @success = true
    else
      @success = false
    end
  end
end
