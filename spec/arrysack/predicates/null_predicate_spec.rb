# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::NullPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, nil).values_match? }
    let(:value) { nil }

    context 'when value is nil' do
      it { is_expected.to eq(true) }
    end

    context 'when value is true' do
      let(:value) { true }
      it { is_expected.to eq(false) }
    end

    context 'when value invalid type' do
      let(:value) { 'invalid type' }
      it { is_expected.to eq(false) }
    end
  end
end
