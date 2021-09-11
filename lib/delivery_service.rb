# frozen_string_literal: true

require_relative 'car'
require_relative 'bike'

# class DeliveryService
class DeliveryService
  attr_reader :autopark

  def initialize
    @autopark = []
    Constants::Cars::QUANTITY.times { autopark << Car.new }
    Constants::Bikes::QUANTITY.times { autopark << Bike.new }
  end

  def create_delivery(weight, distance)
    raise 'Argument must be a number.' unless weight.is_a?(Integer) && distance.is_a?(Integer)

    vehicles = @autopark.select { |item| item.max_weight >= weight }

    add_function_max_distance_to_object_car(vehicles, :max_distance)

    vehicles.select! { |item| item.max_distance >= distance }
    raise 'Does not fit the requirements.' if vehicles.empty?

    vehicles.select!(&:available)
    raise 'Transport unavailable.' if vehicles.empty?

    select_priority(vehicles)
  end

  private

  def select_priority(vehicles)
    vehicles.sort_by!(&:max_weight)

    vehicle_start = vehicles.first
    vehicle_end = vehicles.last
    garage = []
    if (vehicle_start <=> vehicle_end).zero?
      vehicles.first.available = false
      vehicles.shift
      vehicles
    else
      add_the_smallest(garage, vehicles, vehicle_end)
    end
  end

  def add_the_smallest(store, collection, object)
    collection[0...collection.size - 1].each do |item|
      store << item if item < object
    end
    raise 'Transport unavailable.' if store.empty?

    store.first.available = false
    store.shift
    store
  end

  def add_function_max_distance_to_object_car(object, function)
    object.each do |item|
      next if item.respond_to?(function)

      def item.max_distance
        Float::INFINITY
      end
    end
  end
end
