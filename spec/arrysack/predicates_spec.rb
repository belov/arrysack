# frozen_string_literal: true

require 'rspec'

RSpec.describe Arrysack::Predicates do
  describe '.find' do
    subject { described_class.find(name) }

    context 'when name exist' do
      let(:name) { 'eq' }
      it { expect(subject).to be }
      it { expect(subject.symbol).to eq('eq') }
    end

    context 'when name not exist' do
      let(:name) { 'invalid_predicate' }
      it { expect(subject).to be_nil }
    end
  end

  describe '.all' do
    subject { described_class.all }

    it { expect(subject.size).to eq(23) }
  end

  describe '.index' do
    subject { described_class.index }

    let(:predicates_size) { 23 }

    it { expect(subject.keys.compact.size).to eq(predicates_size) }
    it { expect(subject.values.compact.size).to eq(predicates_size) }
  end
end
