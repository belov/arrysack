# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::NotEndPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }
    let(:value) { 'text' }

    context 'when query value end of value' do
      let(:query_value) { 'xt' }
      it { is_expected.to eq(false) }
    end

    context 'when query value not end of value' do
      let(:query_value) { 'ot' }
      it { is_expected.to eq(true) }
    end
  end
end
