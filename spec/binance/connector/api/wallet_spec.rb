# frozen_string_literal: true

RSpec.describe Binance::Connector::Api::Wallet do
  include_context 'with environment variables'

  describe '.system_status' do
    let(:json) { File.read('spec/fixtures/wallet/system_status.json') }

    before do
      allow(HTTParty).to receive(:get).and_return(json)
    end

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
