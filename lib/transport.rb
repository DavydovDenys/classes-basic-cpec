# frozen_string_literal: true

require 'pry'
# class Transport
class Transport
  include Comparable

  attr_accessor :available
  attr_reader :max_weight, :speed, :location, :number_of_deliveries, :delivery_cost

  @park = []

  def <=>(other)
    delivery_speed_by_weight <=> other.delivery_speed_by_weight
  end

  def initialize(max_weight, speed, available)
    @max_weight = max_weight
    @speed = speed.to_f
    @available = available
    @location = Constants::LOCATION[0]
    @number_of_deliveries = 0
    @delivery_cost = 0
    self.class.park << self
  end

  class << self
    attr_reader :park

    def filter_by(attribute, &block)
      objects_with_given_attributes = park.select { |p| p.respond_to?(attribute) }
      return objects_with_given_attributes.to_enum(:each) unless block_given?

      objects_with_given_attributes
        .map { |object| object if block.call(object.public_send(attribute)) }
        .compact
    end

    def find_by(attribute, value)
      objects_with_given_attributes = park.select { |p| p.respond_to?(attribute) }

      result = nil
      objects_with_given_attributes.each do |object|
        if object.send(attribute) == value
          result = object
          break
        end
      end
      result
    end

    def all
      @park
    end
  end

  def delivery_time(distance)
    (distance / speed).round(2)
  end

  def delivery_speed_by_weight
    (speed / max_weight).round(2)
  end
end
