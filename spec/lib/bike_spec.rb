# frozen_string_literal: true

describe Bike do
  let(:bike) { described_class.new }
  let(:speed) { Constants::BIKES[:speed] }
  let(:max_weight) { Constants::BIKES[:max_weight] }
  let(:max_distance) { Constants::BIKES[:max_distance] }

  describe '.new' do
    it do
      expect(bike).to be_instance_of(Bike)
    end
  end

  describe '#available' do
    it do
      expect(bike.available).to be_truthy
    end
  end

  describe '@speed' do
    it do
      expect(bike.speed).to eq(speed)
    end
  end

  describe '@max_weight' do
    it do
      expect(bike.max_weight).to eq(max_weight)
    end
  end

  describe '@max_distance' do
    it do
      expect(bike.max_distance).to eq(max_weight)
    end
  end

  describe '#delivery_time' do
    let(:distance) { 123 }
    let(:result) { (distance / bike.speed.to_f).round(2) }

    it do
      expect(bike.delivery_time(distance)).to be_kind_of(Float)
    end

    it do
      allow(bike).to receive(:delivery_time).with(distance).and_return(result)

      expect(bike.delivery_time(distance)).to eq(12.3)
    end
  end

  describe '#delivery_speed_by_weight' do
    let(:result) { (bike.speed.to_f / bike.max_weight).round(2) }

    it do
      expect(bike.delivery_speed_by_weight).to be_kind_of(Float)
    end

    it do
      allow(bike).to receive(:delivery_speed_by_weight).and_return(result)

      expect(bike.delivery_speed_by_weight).to eq(0.33)
    end
  end
end
