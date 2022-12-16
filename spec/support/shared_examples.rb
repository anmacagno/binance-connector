# frozen_string_literal: true

RSpec.shared_examples 'a contract' do
  context 'with an invalid key' do
    let(:args) { { unexpected: :reality } }

    it 'fails' do
      expect(errors).to include(unexpected: ['is not allowed'])
    end
  end
end
