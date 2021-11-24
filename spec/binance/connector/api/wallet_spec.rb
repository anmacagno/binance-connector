# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Wallet do
  include_context 'with environment variables'
  include_context 'with mocked http responses'

  describe '.system_status' do
    let(:json) { File.read('spec/fixtures/wallet/system_status.json') }

    it 'succeeds' do
      expect(described_class.system_status).to eq(
        {
          status: 0,
          msg: 'normal'
        }
      )
    end
  end
end
