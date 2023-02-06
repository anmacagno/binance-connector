# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Wallet do
  subject(:api) { Binance::Connector::Api.new }

  include_context 'with mocked http responses'

  describe '.system_status' do
    let(:json) { file_fixture('wallet/system_status.json') }

    it 'succeeds' do
      expect(api.system_status).to eq(
        {
          status: 0,
          msg: 'normal'
        }
      )
    end
  end
end
