# frozen_string_literal: true

require_relative 'lib/binance/connector/version'

Gem::Specification.new do |spec|
  spec.name          = 'binance-connector'
  spec.version       = Binance::Connector::VERSION
  spec.authors       = ['anmacagno']
  spec.email         = ['anmacagno@gmail.com']

  spec.summary       = 'Connector to Binance API'
  spec.description   = 'Connector to Binance API implemented in Ruby'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-validation', '~> 1.10'
  spec.add_dependency 'httparty', '~> 0.20'
end
