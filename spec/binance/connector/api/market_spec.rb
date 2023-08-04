# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Market do
  subject(:api) { Binance::Connector::Api.new }

  include_context 'with stubbed http requests'

  describe '#ping' do
    it 'succeeds' do
      expect(api.ping).to eq(
        success_response
      )
    end
  end

  describe '#time' do
    it 'succeeds' do
      expect(api.time).to eq(
        success_response
      )
    end
  end

  describe '#exchange_info' do
    it 'succeeds' do
      expect(api.exchange_info(symbols: %w[BTCUSDT ETHUSDT])).to eq(
        success_response
      )
    end
  end

  describe '#klines' do
    it 'succeeds' do
      expect(api.klines(symbol: 'BTCUSDT', interval: '1d', startTime: Time.utc(2022), endTime: Time.utc(2023))).to eq(
        success_response
      )
    end
  end

  describe '#avg_price' do
    it 'succeeds' do
      expect(api.avg_price(symbol: 'BTCUSDT')).to eq(
        success_response
      )
    end
  end

  describe '#ticker_price' do
    it 'succeeds' do
      expect(api.ticker_price(symbols: %w[BTCUSDT ETHUSDT])).to eq(
        success_response
      )
    end
  end
end
