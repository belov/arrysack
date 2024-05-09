# frozen_string_literal: true

require 'rspec'

RSpec.describe Arrysack::ItemValue do
  describe 'extract' do
    subject { described_class.new(item, methods_chain).extract }
    let(:item) {}
    let(:methods_chain) { %i[a b] }

    context 'when item is Hash' do
      let(:item) { { a: { b: 10 }, c: 15 } }

      it { is_expected.to eq(10) }

      context 'and methods_chain array of string' do
        let(:methods_chain) { %w[a b] }

        it { is_expected.to eq(10) }
      end
    end

    context 'when item is Hash with Array' do
      let(:item)  { { a: { b: [10, 12, 13] }, c: 15 } }
      it { is_expected.to eq([10, 12, 13]) }
    end

    context 'when item is Hash with Array of Hash' do
      let(:methods_chain) { %w[a b d] }
      let(:item) { { a: { b: [{ d: 10 }, { d: 12 }, { d: 13 }] }, c: 15 } }

      it { is_expected.to eq([10, 12, 13]) }
    end

    context 'when item is Object' do
      let(:item) { OpenStruct.new({ a: OpenStruct.new({ b: 10 }), c: 15 }) }

      it { is_expected.to eq(10) }
    end

    context 'when item is Object with Array' do
      let(:item) { OpenStruct.new({ a: OpenStruct.new({ b: [10, 12, 13] }), c: 15 }) }

      it { is_expected.to eq([10, 12, 13]) }
    end

    context 'when item is Object with Array of Object' do
      let(:methods_chain) { %w[a b d] }
      let(:item) do
        list = [OpenStruct.new({ d: 10 }), OpenStruct.new({ d: 12 }), OpenStruct.new({ d: 13 })]
        OpenStruct.new({ a: OpenStruct.new({ b: list }), c: 15 })
      end

      it { is_expected.to eq([10, 12, 13]) }
    end
  end
end
