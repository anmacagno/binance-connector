# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Account do
  describe '.account' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account/account.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.account.keys).to match_array(
        %i[
          makerCommission takerCommission buyerCommission sellerCommission canTrade
          canWithdraw canDeposit updateTime accountType balances permissions
        ]
      )
    end
  end

  describe '.new_order_test' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account/new_order_test.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:post).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.new_order_test('ETHUSDT', 'BUY', 'MARKET', 10)).to eq(
        {}
      )
    end
  end

  describe '.new_order' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account/new_order.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:post).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.new_order('ETHUSDT', 'BUY', 'MARKET', 10).keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId transactTime price origQty
          executedQty cummulativeQuoteQty status timeInForce type side fills
        ]
      )
    end
  end

  describe '.cancel_order' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account/cancel_order.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:delete).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.cancel_order('AVAXUSDT', '794968499').keys).to match_array(
        %i[
          symbol origClientOrderId orderId orderListId clientOrderId price
          origQty executedQty cummulativeQuoteQty status timeInForce type side
        ]
      )
    end
  end

  describe '.query_order' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account/query_order.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.query_order('AVAXUSDT', '794968499').keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId price origQty executedQty cummulativeQuoteQty status
          timeInForce type side stopPrice icebergQty time updateTime isWorking origQuoteOrderQty
        ]
      )
    end
  end

  describe '.all_orders' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account/all_orders.json'), symbolize_names: true) }

    before do
      allow(Binance::Connector::HttpClient).to receive(:get).and_return(json)
    end

    it 'succeeds' do
      expect(described_class.all_orders('AVAXUSDT').first.keys).to match_array(
        %i[
          symbol orderId orderListId clientOrderId price origQty executedQty cummulativeQuoteQty status
          timeInForce type side stopPrice icebergQty time updateTime isWorking origQuoteOrderQty
        ]
      )
    end
  end
end
