# frozen_string_literal: true

RSpec.shared_context 'with environment variables' do
  before do
    allow(ENV).to receive(:fetch).with('BINANCE_BASE_URL').and_return(
      'https://api.binance.com'
    )
    allow(ENV).to receive(:fetch).with('BINANCE_API_KEY').and_return(
      'vmPUZE6mv9SD5VNHk4HlWFsOr6aKE2zvsw0MuIgwCIPy6utIco14y7Ju91duEh8A'
    )
    allow(ENV).to receive(:fetch).with('BINANCE_SECRET_KEY').and_return(
      'NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j'
    )
  end
end

RSpec.shared_context 'with mocked http responses' do
  before do
    allow(HTTParty).to receive(:get).and_return(json)
    allow(HTTParty).to receive(:post).and_return(json)
    allow(HTTParty).to receive(:delete).and_return(json)
  end
end
