# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Wallet do
  subject(:api) { Binance::Connector::Api.new }

  include_context 'with mocked http responses'

  describe '#system_status' do
    it 'succeeds' do
      expect(api.system_status).to eq(
        success_response
      )
    end
  end

  describe '#get_user_asset' do
    it 'succeeds' do
      expect(api.get_user_asset(asset: 'BTC')).to eq(
        success_response
      )
    end
  end
end
