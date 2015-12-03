require_relative './parking_manager'

# Parking Director
class ParkingDirector
  def initialize(manager)
    @manager = manager
  end

  def report
    gen_report(0, @manager)
  end

  private

  def gen_report(indent, parkable)
    report = parkable.report_string(indent)
    return report if parkable.is_a?(ParkingLot)

    parkable.containers.inject(report) { |a, e| a << gen_report(indent + 2, e) }
  end
end
