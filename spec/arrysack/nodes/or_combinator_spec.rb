# frozen_string_literal: true

require 'rspec'

RSpec.describe Arrysack::Nodes::OrCombinator do
  describe '#result' do
    subject { described_class.new(list).result }

    context 'when list empty' do
      let(:list) { [] }
      it { is_expected.to eq(false) }
    end

    context 'when list has only false' do
      let(:list) { [false, false] }
      it { is_expected.to eq(false) }
    end

    context 'when list has true' do
      let(:list) { [false, false, true] }
      it { is_expected.to eq(true) }
    end
  end
end
