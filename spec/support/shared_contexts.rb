# frozen_string_literal: true

RSpec.shared_context 'with mocked http responses' do
  before do
    allow(HTTParty).to receive(:get).and_return(json)
    allow(HTTParty).to receive(:post).and_return(json)
    allow(HTTParty).to receive(:delete).and_return(json)
  end
end
