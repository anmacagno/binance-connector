# frozen_string_literal: true

RSpec.shared_context 'with mocked http responses' do
  let(:json_response) { '{}' }
  let(:success_response) { JSON.parse(json_response, symbolize_names: true) }

  before do
    allow(HTTParty).to receive_messages(get: json_response, post: json_response, delete: json_response)
  end
end
