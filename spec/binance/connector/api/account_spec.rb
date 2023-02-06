# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Account do
  subject(:api) { Binance::Connector::Api.new }

  include_context 'with mocked http responses'

  describe '.new_order_test' do
    let(:json) { file_fixture('account/new_order_test.json') }

    it 'creates a buy market order' do
      expect(api.new_order_test('ETHUSDT', 'BUY', 'MARKET', nil, nil, 10, nil)).to eq(
        {}
      )
    end
  end

  describe '.new_order' do
    let(:json) { file_fixture('account/new_order.json') }

    it 'creates a buy limit order' do
      expect(api.new_order('AVAXUSDT', 'BUY', 'LIMIT', 'GTC', 1, nil, 60).keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId transactTime price origQty
          executedQty cummulativeQuoteQty status timeInForce type side fills
        ]
      )
    end
  end

  describe '.cancel_order' do
    let(:json) { file_fixture('account/cancel_order.json') }

    it 'succeeds' do
      expect(api.cancel_order('AVAXUSDT', '794968499').keys).to match_array(
        %i[
          symbol origClientOrderId orderId orderListId clientOrderId price
          origQty executedQty cummulativeQuoteQty status timeInForce type side
        ]
      )
    end
  end

  describe '.cancel_open_orders' do
    let(:json) { file_fixture('account/cancel_open_orders.json') }

    it 'succeeds' do
      expect(api.cancel_open_orders('SOLBUSD').first.keys).to match_array(
        %i[
          symbol origClientOrderId orderId orderListId clientOrderId price
          origQty executedQty cummulativeQuoteQty status timeInForce type side
        ]
      )
    end
  end

  describe '.get_order' do
    let(:json) { file_fixture('account/get_order.json') }

    it 'succeeds' do
      expect(api.get_order('AVAXUSDT', '794968499').keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId price origQty executedQty cummulativeQuoteQty status
          timeInForce type side stopPrice icebergQty time updateTime isWorking origQuoteOrderQty
        ]
      )
    end
  end

  describe '.get_open_orders' do
    let(:json) { file_fixture('account/get_open_orders.json') }

    it 'succeeds' do
      expect(api.get_open_orders('SOLBUSD').first.keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId price origQty executedQty cummulativeQuoteQty status
          timeInForce type side stopPrice icebergQty time updateTime isWorking origQuoteOrderQty
        ]
      )
    end
  end

  describe '.get_orders' do
    let(:json) { file_fixture('account/get_orders.json') }

    it 'succeeds' do
      expect(api.get_orders('AVAXUSDT').first.keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId price origQty executedQty cummulativeQuoteQty status
          timeInForce type side stopPrice icebergQty time updateTime isWorking origQuoteOrderQty
        ]
      )
    end
  end

  describe '.account' do
    let(:json) { file_fixture('account/account.json') }

    it 'succeeds' do
      expect(api.account.keys).to match_array(
        %i[
          makerCommission takerCommission buyerCommission sellerCommission canTrade
          canWithdraw canDeposit updateTime accountType balances permissions
        ]
      )
    end
  end

  describe '.my_trades' do
    let(:json) { file_fixture('account/my_trades.json') }

    it 'succeeds' do
      expect(api.my_trades('XRPUSDT', nil).first.keys).to match_array(
        %i[
          symbol id orderId orderListId price qty quoteQty commission commissionAsset time isBuyer isMaker isBestMatch
        ]
      )
    end
  end
end
