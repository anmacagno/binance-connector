# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Account do
  describe '.account' do
    let(:json) { JSON.parse(File.read('spec/fixtures/account.json'), symbolize_names: true) }

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
end
