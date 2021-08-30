class Transport
  include Comparable

  attr_accessor :available
  attr_reader :max_weight, :speed

  def <=>(other)
    delivery_speed_by_weight <=> other.delivery_speed_by_weight
  end

  def initialize(max_weight, speed, available)
    @max_weight = max_weight
    @speed = speed.to_f
    @available = available
  end

  def delivery_time(distance)
    (distance / speed).round(2)
  end

  def delivery_speed_by_weight
    (speed / max_weight).round(2)
  end
end
