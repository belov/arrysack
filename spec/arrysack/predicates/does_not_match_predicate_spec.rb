# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::DoesNotMatchPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }
    let(:value) { 'text' }

    context 'when value matched string' do
      let(:query_value) { 'ex' }
      it { is_expected.to eq(false) }
    end

    context 'when value not matched string' do
      let(:query_value) { 'op' }
      it { is_expected.to eq(true) }
    end

    context 'when query_value not matched regexp' do
      let(:query_value) { '\d' }
      it { is_expected.to eq(true) }
    end

    context 'when query_value matched regexp' do
      let(:query_value) { '\S{4}' }
      it { is_expected.to eq(false) }
    end
  end
end
