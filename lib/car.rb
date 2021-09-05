# frozen_string_literal: true

require_relative 'transport'
require_relative 'constants'

# class Car
class Car < Transport
  attr_accessor :number

  def initialize
    super(Constants::CARS[:max_weight], Constants::CARS[:speed], true)
    park << self
  end
end
