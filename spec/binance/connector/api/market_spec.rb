# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Market do
  subject(:api) { Binance::Connector::Api.new }

  include_context 'with mocked http responses'

  describe '.ping' do
    let(:json) { file_fixture('market/ping.json') }

    it 'succeeds' do
      expect(api.ping).to eq(
        {}
      )
    end
  end

  describe '.time' do
    let(:json) { file_fixture('market/time.json') }

    it 'succeeds' do
      expect(api.time.keys).to match_array(
        %i[serverTime]
      )
    end
  end

  describe '.exchange_info' do
    let(:json) { file_fixture('market/exchange_info.json') }

    it 'succeeds' do
      expect(api.exchange_info(symbols: %w[BTCUSDT ETHUSDT]).keys).to match_array(
        %i[timezone serverTime rateLimits exchangeFilters symbols]
      )
    end
  end

  describe '.klines' do
    let(:json) { file_fixture('market/klines.json') }

    it 'succeeds' do
      expect(api.klines(symbol: 'ETHUSDT', interval: '1d', limit: 7).size).to eq(7)
    end
  end

  describe '.avg_price' do
    let(:json) { file_fixture('market/avg_price.json') }

    it 'succeeds' do
      expect(api.avg_price(symbol: 'ETHUSDT').keys).to match_array(
        %i[mins price]
      )
    end
  end

  describe '.ticker_price' do
    let(:json) { file_fixture('market/ticker_price.json') }

    it 'succeeds' do
      expect(api.ticker_price(symbols: %w[BTCUSDT ETHUSDT]).keys).to match_array(
        %i[symbol price]
      )
    end
  end
end
