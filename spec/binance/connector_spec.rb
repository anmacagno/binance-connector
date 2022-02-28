# frozen_string_literal: true

RSpec.describe Binance::Connector do
  it 'has a version number' do
    expect(Binance::Connector::VERSION).not_to be_nil
  end
end
