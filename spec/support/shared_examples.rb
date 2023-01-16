# frozen_string_literal: true

RSpec.shared_examples 'a contract' do |validations:|
  describe '#call' do
    subject(:errors) { described_class.new.call(args).errors.to_h }

    validations[:required]&.each do |key|
      context "when #{key} is not present" do
        let(:args) { {} }

        it 'fails' do
          expect(errors).to include(key => ['is missing'])
        end
      end
    end

    validations[:integer]&.each do |key|
      context "when #{key} is nil" do
        let(:args) { { key => nil } }

        it 'fails' do
          expect(errors).to include(key => ['must be an integer'])
        end
      end
    end

    validations[:string]&.each do |key|
      context "when #{key} is nil" do
        let(:args) { { key => nil } }

        it 'fails' do
          expect(errors).to include(key => ['must be a string'])
        end
      end

      context "when #{key} is empty" do
        let(:args) { { key => '' } }

        it 'fails' do
          expect(errors).to include(key => ['must be filled'])
        end
      end
    end

    validations[:time]&.each do |key|
      context "when #{key} is nil" do
        let(:args) { { key => nil } }

        it 'fails' do
          expect(errors).to include(key => ['must be a time'])
        end
      end
    end

    validations[:format]&.each do |key|
      context "when #{key} is invalid" do
        let(:args) { { key => ':' } }

        it 'fails' do
          expect(errors).to include(key => ['is in invalid format'])
        end
      end
    end

    validations[:inclusion]&.each do |key|
      context "when #{key} is invalid" do
        let(:args) { { key => ':' } }

        it 'fails' do
          expect(errors[key]).to include(/must be one of:/)
        end
      end
    end

    validations[:array]&.each do |key|
      context "when #{key} is nil" do
        let(:args) { { key => nil } }

        it 'fails' do
          expect(errors).to include(key => ['must be an array'])
        end
      end

      context "when #{key} is empty" do
        let(:args) { { key => [] } }

        it 'fails' do
          expect(errors).to include(key => ['size cannot be less than 1'])
        end
      end

      context "when #{key} has a nil element" do
        let(:args) { { key => [nil] } }

        it 'fails' do
          expect(errors).to include(key => { 0 => ['must be a string'] })
        end
      end

      context "when #{key} has an empty element" do
        let(:args) { { key => [''] } }

        it 'fails' do
          expect(errors).to include(key => { 0 => ['must be filled'] })
        end
      end
    end

    context 'with an invalid key' do
      let(:args) { { unexpected: :reality } }

      it 'fails' do
        expect(errors).to include(unexpected: ['is not allowed'])
      end
    end
  end
end
