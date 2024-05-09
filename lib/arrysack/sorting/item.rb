# frozen_string_literal: true

require_relative '../item_value'
module Arrysack
  module Sorting
    class Item
      using Arrysack::CoreExt
      include Comparable

      attr_reader :item, :values, :dirs

      DIR_ASC = 'asc'
      DIR_DESC = 'desc'
      DIRS = [DIR_ASC, DIR_DESC].freeze

      def initialize(item:, values: [], dirs: [], null_first: false)
        @item = item
        @values = Array.wrap(values)
        @null_first = null_first
        @dirs = Array.wrap(dirs).map(&:to_s).map(&:downcase).map { |e| DIRS.include?(e) ? e : DIR_ASC }
        @left_nil_order = null_first? ? -1 : 1
        @right_nil_order = -1 * @left_nil_order
      end

      def <=>(other)
        pairs = values.zip(other.values)

        size = pairs.size
        c = 0
        i = 0
        while c.zero? && i < size
          pair = pairs[i]
          c = compare_pair(pair[0], pair[1], asc?(i))
          i += 1
        end
        c
      end

      private

      attr_reader :left_nil_order, :right_nil_order

      def compare_pair(left, right, dir_asc)
        return left_nil_order  unless left.is_a?(Comparable)
        return right_nil_order unless right.is_a?(Comparable)

        dir_asc ? left <=> right : right <=> left
      end

      def asc?(index)
        dirs[index] == DIR_ASC
      end

      def null_first?
        !!@null_first
      end
    end
  end
end
