# frozen_string_literal: true

RSpec.describe Arrysack::Predicates::NotEqPredicate do
  describe '#values_match?' do
    subject { described_class.new(value, query_value).values_match? }
    let(:value) { 'text' }

    context 'when value eq string' do
      let(:query_value) { 'text' }
      it { is_expected.to eq(false) }
    end

    context 'when value not eq string' do
      let(:query_value) { 'next' }
      it { is_expected.to eq(true) }
    end

    context 'when value eq number' do
      let(:value) { 10.3 }
      let(:query_value) { 10.3 }
      it { is_expected.to eq(false) }
    end

    context 'when value not eq number' do
      let(:value) { 10.3 }
      let(:query_value) { 10.1 }
      it { is_expected.to eq(true) }
    end
  end
end
