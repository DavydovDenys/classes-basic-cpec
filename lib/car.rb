# frozen_string_literal: true

require_relative 'transport'
require_relative 'constants'

# class Car
class Car < Transport
  attr_accessor :number

  @park = []

  def initialize
    super(Constants::Cars::MAX_WEIGHT, Constants::Cars::SPEED, true)
  end
end
