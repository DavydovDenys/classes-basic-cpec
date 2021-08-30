require_relative 'car'
require_relative 'bike'

class DeliveryService
  attr_reader :cars, :bikes

  def initialize
    @cars  = Array.new(Constants::CARS[:quantity]) { Car.new }
    @bikes = Array.new(Constants::BIKES[:quantity]) { Bike.new }
  end

  def create_delivery(weight, distance)
    bike_availability = @bikes.map(&:available)
    car_availability  = @cars.map(&:available)

    # by bike
    if weight <= 10 && distance <= 30
      if bike_availability.include?(true)
        available_bike = bike_availability.find_index(true)
        @bikes[available_bike].available = false
        'by bike'
      else
        'bike unavailable, try again later.'
      end
    # by car
    else
      if car_availability.include?(true)
        available_car = car_availability.find_index(true)
        @cars[available_car].available = false
        'by car'
      else
        'car unavailable, try again later.'
      end
    end 
  end
end
