# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Market do
  describe '.ping' do
    let(:json) { JSON.parse(File.read('spec/fixtures/ping.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.ping).to eq(
        {}
      )
    end
  end

  describe '.time' do
    let(:json) { JSON.parse(File.read('spec/fixtures/time.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.time.keys).to match_array(
        %i[serverTime]
      )
    end
  end

  describe '.exchange_info' do
    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    context 'when the symbols are valid' do
      let(:json) { JSON.parse(File.read('spec/fixtures/exchangeInfo.json'), symbolize_names: true) }

      it 'succeeds' do
        expect(described_class.exchange_info(%w[BTCUSDT ETHUSDT]).keys).to match_array(
          %i[timezone serverTime rateLimits exchangeFilters symbols]
        )
      end
    end
  end

  describe '.avg_price' do
    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    context 'when the symbol is valid' do
      let(:json) { JSON.parse(File.read('spec/fixtures/avgPrice.json'), symbolize_names: true) }

      it 'succeeds' do
        expect(described_class.avg_price('ETHUSDT').keys).to match_array(
          %i[mins price]
        )
      end
    end
  end
end
