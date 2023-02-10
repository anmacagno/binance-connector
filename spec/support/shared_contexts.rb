# frozen_string_literal: true

RSpec.shared_context 'with mocked http responses' do
  let(:json_response) { '{}' }
  let(:success_response) { JSON.parse(json_response, symbolize_names: true) }

  before do
    allow(HTTParty).to receive(:get).and_return(json_response)
    allow(HTTParty).to receive(:post).and_return(json_response)
    allow(HTTParty).to receive(:delete).and_return(json_response)
  end
end
