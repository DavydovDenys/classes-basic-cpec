# frozen_string_literal: true

describe Transport do
  let(:transport) { described_class.new(100, 50, true) }
  let(:car) { Car.new }
  let(:bike) { Bike.new }

  it do
    expect(transport).to be_instance_of(described_class)
  end

  describe '.filter_by' do
    let(:enumerator) { Car.filter_by(:available) }

    context 'when block is not given' do
      it 'returns Enumerator' do
        expect(enumerator).to be_kind_of(Enumerator)
        expect(enumerator).to respond_to(:next)
      end
    end

    context 'when block is given' do
      it 'returns Array with objects' do
        expect(Car.filter_by(:speed) { |s| s > 30 }).to be_kind_of(Array)
      end
    end

    context 'when block is given and params matched the object' do
      it 'returns Array with objects' do
        allow(described_class).to receive(:park).and_return([])
        filter_by_number = Car.filter_by(:number) { |n| n == 777 }

        expect(filter_by_number).to eq([])

        2.times { Car.new }
        Car.park.last.number = 777
        Car.park.first.number = 777
        filter_by_number = Car.filter_by(:number) { |n| n == 777 }

        expect(filter_by_number.count).to eq(2)
      end
    end

    context 'when block is given and params do not match the object' do
      it 'returns an empty Array' do
        filter_by_speed = Car.filter_by(:speed) { |n| n > 100 }

        expect(filter_by_speed).to eq([])
      end
    end
  end

  describe '.find_by' do
    context 'when params matched the object' do
      it 'returns the object' do
        expect(Bike.find_by(:available, true)).to eq(bike)
      end

      it 'returns the first object that matched the params' do
        allow(described_class).to receive(:park).and_return([])

        2.times { Bike.new }
        available_bikes = Bike.filter_by(:available) { |b| b == true }

        expect(available_bikes.count).to eq(2)

        available_bike = Bike.find_by(:available, true)

        expect(available_bike).to eq(bike)
      end
    end

    context 'when params do not match the object' do
      it 'returns nil' do
        allow(described_class).to receive(:park).and_return([])

        3.times { Bike.new }

        expect(Bike.park.count).to eq(3)
        expect(Bike.find_by(:location, 'on route')).to be_nil
      end
    end
  end

  describe '.all' do
    it 'returns Array with objects' do
      expect(described_class.all).to be_kind_of(Array)
    end

    it 'returns Array with Car objects' do
      expect(Car.all).to include(car)
    end

    it 'returns Array with Bikes objects' do
      expect(Bike.all).to include(bike)
    end
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
