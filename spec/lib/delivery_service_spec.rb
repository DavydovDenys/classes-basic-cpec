# frozen_string_literal: true

describe DeliveryService do
  let(:delivery_service) { described_class.new }

  describe '.new' do
    it do
      expect(delivery_service).to be_instance_of(DeliveryService)
    end
  end

  describe '#autopark' do
    let(:autopark) { delivery_service.cars + delivery_service.bikes }

    it do
      expect(delivery_service.autopark).to be_kind_of(Array)
    end

    it 'returns array with Car and Bike objects' do
      allow(delivery_service).to receive(:cars).and_return([Car.new])
      allow(delivery_service).to receive(:bikes).and_return([Bike.new])
      allow(delivery_service).to receive(:autopark).and_return(autopark)

      expect(delivery_service.autopark).to eq(autopark)
    end
  end

  describe '#cars' do
    it do
      expect(delivery_service.cars.first).to be_kind_of(Car)
    end
  end

  describe '#bikes' do
    it do
      expect(delivery_service.bikes.first).to be_kind_of(Bike)
    end
  end

  describe '#create_delivery' do
    context 'errors' do
      context 'when invalid arguments' do
        it 'returns RuntimeError' do
          expect { delivery_service.create_delivery('weight', '20') }
            .to raise_error(RuntimeError, 'Argument must be a number.')
        end
      end

      context 'when the object does not match the parameters' do
        it 'returns RuntimeError' do
          expect { delivery_service.create_delivery(110, 120) }
            .to raise_error(RuntimeError, 'Does not fit the requirements.')
        end
      end

      context 'when all objects have @available = false' do
        it 'returns RuntimeError' do
          delivery_service.autopark.each { |auto| auto.available = false }

          expect { delivery_service.create_delivery(11, 12) }
            .to raise_error(RuntimeError, 'Transport unavailable.')
        end
      end
    end

    context 'when arguments fit Bike object' do
      it 'returns array of Bike objects' do
        expect(delivery_service.create_delivery(10, 20)).to eq([Bike.new, Bike.new])
      end

      it 'changes (available = true) to false' do
        bikes = delivery_service.bikes.select(&:available)

        expect(bikes.count).to eq(3)

        delivery_service.create_delivery(10, 20)

        bikes = delivery_service.bikes.select(&:available)

        expect(bikes.count).to eq(2)
      end
    end

    context 'when arguments do not fit Bike object' do
      it 'returns array of Car objects' do
        expect(delivery_service.create_delivery(100, 20)).to eq([Car.new])
      end

      it 'does not change (available = true) to false' do
        bikes = delivery_service.bikes.select(&:available)

        expect(bikes.count).to eq(3)

        delivery_service.create_delivery(100, 20)

        bikes = delivery_service.bikes.select(&:available)

        expect(bikes.count).to eq(3)
      end
    end

    context 'when arguments fit Car object' do
      it 'returns array of Car objects' do
        expect(delivery_service.create_delivery(100, 20)).to eq([Car.new])
      end

      it 'changes (available = true) to false' do
        cars = delivery_service.cars.select(&:available)

        expect(cars.count).to eq(2)

        delivery_service.create_delivery(100, 20)

        cars = delivery_service.cars.select(&:available)

        expect(cars.count).to eq(1)
      end
    end

    context 'when arguments do not fit Car object' do
      it 'returns array of Bike objects' do
        expect(delivery_service.create_delivery(10, 20)).to eq([Bike.new, Bike.new])
      end

      it 'does not change (available = true) to false' do
        cars = delivery_service.cars.select(&:available)

        expect(cars.count).to eq(2)

        delivery_service.create_delivery(10, 20)

        cars = delivery_service.cars.select(&:available)

        expect(cars.count).to eq(2)
      end
    end
  end
end
