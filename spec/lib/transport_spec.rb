# frozen_string_literal: true

describe Transport do
  let(:transport) { described_class.new(car.max_weight, car.speed, true) }
  let(:car) { Car.new }
  let(:bike) { Bike.new }

  it do
    expect(transport).to be_instance_of(Transport)
  end

  describe '#delivery_time' do
    context 'when Car #delivery_time' do
      let(:distance) { 100 }

      it do
        expect(car.delivery_time(distance)).to eq((distance / car.speed.to_f).round(2))
      end
    end

    context 'when Bike #delivery_time' do
      let(:distance) { 100 }

      it do
        expect(bike.delivery_time(distance)).to eq((distance / bike.speed.to_f).round(2))
      end
    end

    context 'when Transport #delivery_time' do
      let(:distance) { 100 }

      it do
        expect(transport.delivery_time(distance)).to eq((distance / transport.speed.to_f).round(2))
      end
    end
  end
end
