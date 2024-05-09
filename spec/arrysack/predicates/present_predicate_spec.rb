# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::PresentPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }
    let(:query_value) { nil }

    context 'when value string' do
      let(:value) { 'string' }
      it { is_expected.to eq(true) }
    end

    context 'when value empty string' do
      let(:value) { '' }
      it { is_expected.to eq(false) }
    end

    context 'when value empty hash' do
      let(:value) { {} }
      it { is_expected.to eq(false) }
    end

    context 'when value empty array' do
      let(:value) { [] }
      it { is_expected.to eq(false) }
    end

    context 'when value false' do
      let(:value) { false }
      it { is_expected.to eq(false) }
    end

    context 'when value nil' do
      let(:value) { nil }
      it { is_expected.to eq(false) }
    end
  end
end
