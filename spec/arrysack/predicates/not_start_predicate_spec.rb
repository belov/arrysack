# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::NotStartPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }
    let(:value) { 'text' }

    context 'when query value start of value' do
      let(:query_value) { 'te' }
      it { is_expected.to eq(false) }
    end

    context 'when query value not start of value' do
      let(:query_value) { 'ex' }
      it { is_expected.to eq(true) }
    end
  end
end
