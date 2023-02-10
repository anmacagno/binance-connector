# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Account do
  subject(:api) { Binance::Connector::Api.new }

  include_context 'with mocked http responses'

  describe '.new_order_test' do
    it 'succeeds' do
      expect(api.new_order_test(symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005)).to eq(
        success_response
      )
    end
  end

  describe '.new_order' do
    it 'succeeds' do
      expect(api.new_order(symbol: 'BTCUSDT', side: 'BUY', type: 'MARKET', quantity: 0.005)).to eq(
        success_response
      )
    end
  end

  describe '.cancel_order' do
    it 'succeeds' do
      expect(api.cancel_order(symbol: 'BTCUSDT', orderId: 1)).to eq(
        success_response
      )
    end
  end

  describe '.get_order' do
    it 'succeeds' do
      expect(api.get_order(symbol: 'BTCUSDT', orderId: 1)).to eq(
        success_response
      )
    end
  end

  describe '.get_open_orders' do
    it 'succeeds' do
      expect(api.get_open_orders(symbol: 'BTCUSDT')).to eq(
        success_response
      )
    end
  end

  describe '.get_orders' do
    it 'succeeds' do
      expect(api.get_orders(symbol: 'BTCUSDT')).to eq(
        success_response
      )
    end
  end

  describe '.account' do
    it 'succeeds' do
      expect(api.account).to eq(
        success_response
      )
    end
  end

  describe '.my_trades' do
    it 'succeeds' do
      expect(api.my_trades(symbol: 'BTCUSDT', orderId: 1)).to eq(
        success_response
      )
    end
  end
end
