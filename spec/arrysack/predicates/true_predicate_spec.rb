# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::TruePredicate do
  describe '#values_match?' do
    subject { described_class.new(value, nil).values_match? }

    context 'when value is false' do
      let(:value) { false }
      it { is_expected.to eq(false) }
    end

    context 'when value is true' do
      let(:value) { true }
      it { is_expected.to eq(true) }
    end

    context 'when value invalid type' do
      let(:value) { 'invalid type' }
      it { is_expected.to eq(false) }
    end
  end
end
