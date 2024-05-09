# frozen_string_literal: true

require_relative '../item_value'
require_relative 'item'
module Arrysack
  module Sorting
    class Collection
      attr_reader :operators, :options

      Operator = Struct.new(:methods_chain, :dir, keyword_init: true)

      def initialize(null_first: false)
        @operators = []
        @null_first = null_first
      end

      def sort(list)
        return list if operators.empty?

        items = list.map { |item| build_item(item) }
        items.sort.map(&:item)
      end

      def add_operator(methods_chain, dir)
        operator = Operator.new(methods_chain: methods_chain, dir: dir)
        operators << operator
      end

      private

      attr_reader :null_first

      def build_item(item)
        values = []
        dirs = []
        operators.each do |o|
          values << ItemValue.new(item, o.methods_chain).extract
          dirs << o.dir
        end
        Item.new(item: item, values: values, dirs: dirs, null_first: null_first)
      end
    end
  end
end
