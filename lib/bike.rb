# frozen_string_literal: true

require_relative 'transport'
require_relative 'constants'

# class Bike
class Bike < Transport
  attr_reader :max_distance

  @park = []

  def initialize
    super(Constants::Bikes::MAX_WEIGHT, Constants::Bikes::SPEED, true)
    @max_distance = Constants::Bikes::MAX_DISTANCE
  end
end
