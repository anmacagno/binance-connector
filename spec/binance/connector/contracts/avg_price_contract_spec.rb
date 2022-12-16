# frozen_string_literal: true

RSpec.describe Binance::Connector::Contracts::AvgPriceContract do
  describe '#call' do
    subject(:errors) { described_class.new.call(args).errors.to_h }

    it_behaves_like 'a contract'

    context 'when symbol is not present' do
      let(:args) { {} }

      it 'fails' do
        expect(errors).to include(symbol: ['is missing'])
      end
    end

    context 'when symbol is nil' do
      let(:args) { { symbol: nil } }

      it 'fails' do
        expect(errors).to include(symbol: ['must be a string'])
      end
    end

    context 'when symbol is empty' do
      let(:args) { { symbol: '' } }

      it 'fails' do
        expect(errors).to include(symbol: ['must be filled'])
      end
    end

    context 'when symbol is invalid' do
      let(:args) { { symbol: ':' } }

      it 'fails' do
        expect(errors).to include(symbol: ['is in invalid format'])
      end
    end
  end
end
