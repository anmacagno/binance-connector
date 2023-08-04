# frozen_string_literal: true

RSpec.shared_context 'with stubbed http requests' do
  let(:success_response) { {} }

  before do
    stub_request(:any, ->(_uri) { true }).to_return(
      body: '{}',
      headers: { content_type: 'application/json' },
      status: 200
    )
  end
end
