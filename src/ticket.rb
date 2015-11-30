require 'securerandom'

# Ticket
class Ticket
  attr_reader :token, :success

  class << self
    def none
      new.tap do |ticket|
        ticket.instance_variable_set(:@token, nil)
        ticket.instance_variable_set(:@success, false)
      end
    end
  end

  def initialize
    @token = SecureRandom.uuid
    @success = true
  end
end
