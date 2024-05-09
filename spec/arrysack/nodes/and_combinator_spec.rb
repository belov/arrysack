# frozen_string_literal: true

require 'rspec'

RSpec.describe Arrysack::Nodes::AndCombinator do
  describe '#result' do
    subject { described_class.new(list).result }

    context 'when list empty' do
      let(:list) { [] }
      it { is_expected.to eq(true) }
    end

    context 'when list has only true' do
      let(:list) { [true, true] }
      it { is_expected.to eq(true) }
    end

    context 'when list has false' do
      let(:list) { [true, false, true] }
      it { is_expected.to eq(false) }
    end
  end
end
