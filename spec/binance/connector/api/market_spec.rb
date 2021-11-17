# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Market do
  describe '.ping' do
    let(:json) { File.read('spec/fixtures/market/ping.json') }

    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.ping).to eq(
        {}
      )
    end
  end

  describe '.time' do
    let(:json) { File.read('spec/fixtures/market/time.json') }

    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.time.keys).to match_array(
        %i[serverTime]
      )
    end
  end

  describe '.exchange_info' do
    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

    context 'when the symbols are valid' do
      let(:json) { File.read('spec/fixtures/market/exchange_info.json') }

      it 'succeeds' do
        expect(described_class.exchange_info(%w[BTCUSDT ETHUSDT]).keys).to match_array(
          %i[timezone serverTime rateLimits exchangeFilters symbols]
        )
      end
    end
  end

  describe '.klines' do
    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

    context 'when the symbol is valid' do
      let(:json) { File.read('spec/fixtures/market/klines.json') }

      it 'succeeds' do
        expect(described_class.klines('ETHUSDT', '1d', nil, nil, '7').size).to eq(7)
      end
    end
  end

  describe '.avg_price' do
    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

    context 'when the symbol is valid' do
      let(:json) { File.read('spec/fixtures/market/avg_price.json') }

      it 'succeeds' do
        expect(described_class.avg_price('ETHUSDT').keys).to match_array(
          %i[mins price]
        )
      end
    end
  end

  describe '.ticker_price' do
    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

    context 'when the symbol is valid' do
      let(:json) { File.read('spec/fixtures/market/ticker_price.json') }

      it 'succeeds' do
        expect(described_class.ticker_price('ETHUSDT').keys).to match_array(
          %i[symbol price]
        )
      end
    end
  end
end
