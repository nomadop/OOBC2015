
# Reportable
module Reportable
  # Class Methods
  module ClassMethods
    attr_reader :capital

    def define_capital(capital)
      @capital = capital
    end
  end

  # Instance Methods
  module InstanceMethods
    def report_string(indent)
      "#{' ' * indent}#{capital} #{parked_count} #{capacity}\n"
    end

    private

    def capital
      self.class.capital
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end
