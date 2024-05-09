# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::NotIContPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }

    describe 'Array' do
      let(:value) { [1, 2, 3] }

      context 'when value empty string' do
        let(:query_value) { '' }
        it { is_expected.to eq(true) }
      end

      context 'when value include' do
        let(:query_value) { 1 }
        it { is_expected.to eq(false) }
      end
    end

    describe 'String' do
      let(:value) { 'example' }

      context 'when value empty string' do
        let(:query_value) { '' }
        it { is_expected.to eq(false) }
      end

      context 'when value camel case string' do
        let(:query_value) { 'Amp' }
        it { is_expected.to eq(false) }
      end

      context 'when value include' do
        let(:query_value) { 'amp' }
        it { is_expected.to eq(false) }
      end
    end
  end
end
