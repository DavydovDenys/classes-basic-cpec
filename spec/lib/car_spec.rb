# frozen_string_literal: true

describe Car do
  let(:car) { described_class.new }
  let(:speed) { Constants::CARS[:speed] }
  let(:max_weight) { Constants::CARS[:max_weight] }

  describe '.new' do
    it do
      expect(car).to be_instance_of(Car)
    end
  end

  describe '@available' do
    it do
      expect(car.available).to be_truthy
    end
  end

  describe '@speed' do
    it do
      expect(car.speed).to eq(speed)
    end
  end

  describe '@max_weight' do
    it do
      expect(car.max_weight).to eq(max_weight)
    end
  end

  describe '#delivery_time' do
    let(:distance) { 123 }
    let(:result) { (distance / car.speed.to_f).round(2) }

    it do
      expect(car.delivery_time(distance)).to be_kind_of(Float)
    end

    it do
      allow(car).to receive(:delivery_time).with(distance).and_return(result)

      expect(car.delivery_time(distance)).to eq(2.46)
    end
  end

  describe '#delivery_speed_by_weight' do
    let(:result) { (car.speed.to_f / car.max_weight).round(2) }

    it do
      expect(car.delivery_speed_by_weight).to be_kind_of(Float)
    end

    it do
      allow(car).to receive(:delivery_speed_by_weight).and_return(result)

      expect(car.delivery_speed_by_weight).to eq(0.5)
    end
  end
end
