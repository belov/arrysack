# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::InPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }

    let(:query_value) { [1, 2, 3] }

    context 'when value empty string' do
      let(:value) { '' }
      it { is_expected.to eq(false) }
    end

    context 'when value include' do
      let(:value) { 1 }
      it { is_expected.to eq(true) }
    end
  end
end
