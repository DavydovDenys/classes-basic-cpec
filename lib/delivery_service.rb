# frozen_string_literal: true

require_relative 'car'
require_relative 'bike'
require 'pry'

# class DeliveryService
class DeliveryService
  attr_reader :cars, :bikes, :autopark

  def initialize
    @cars  = Array.new(Constants::CARS[:quantity]) { Car.new }
    @bikes = Array.new(Constants::BIKES[:quantity]) { Bike.new }
    @autopark = @cars + @bikes
  end

  def create_delivery(weight, distance)
    vehicles = @autopark.select { |item| item.max_weight >= weight }

    add_function_to_object(vehicles, 'max_distance')

    vehicles.select! { |item| item.max_distance >= distance }
    raise 'Does not fit the requirements.' if vehicles.empty?

    vehicles.select!(&:available)
    raise 'Transport unavailable.' if vehicles.empty?

    select_priority(vehicles)
  end

  private

  def select_priority(vehicles)
    garage = []
    vehicle = vehicles.first
    vehicles.each do |item|
      return garage << vehicle if vehicle < item

      return garage << item if vehicle > item

      garage << item
    end
    garage.first.available = false
    garage
  end

  def add_function_to_object(object, function)
    object.each do |item|
      next if item.respond_to?(function.to_sym)

      def item.max_distance
        Float::INFINITY
      end
    end
  end
end
