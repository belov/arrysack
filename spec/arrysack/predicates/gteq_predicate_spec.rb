# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::GteqPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }
    let(:value) { 10 }

    context 'when query_value gt value' do
      let(:query_value) { 5 }
      it { is_expected.to eq(true) }
    end

    context 'when query_value lt value' do
      let(:query_value) { 20 }
      it { is_expected.to eq(false) }
    end

    context 'when query_value eq value' do
      let(:query_value) { 10 }
      it { is_expected.to eq(true) }
    end
  end
end
