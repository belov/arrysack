# frozen_string_literal: true

module Arrysack
  module Parser
    class NameVariants
      using Arrysack::CoreExt
      attr_reader :list, :variants, :splitter

      def initialize(list, splitter: '_')
        @list = list.is_a?(Array) ? list.map(&:to_s) : []
        @splitter = splitter
      end

      def all
        all = slide_variants.sort_by { |variant| variant.first.size }.reverse
        @variants = all.map { |variant| variant.map { |group| group.join(splitter) } }
      end

      class << self
        def all(*args)
          new(*args).all
        end
      end

      def slide_variants
        variants = base_variants(list)
        return [] if variants.flatten.size.zero?
        return variants if variants.flatten.size == 1

        result = []
        loop do
          new_result, new_variants = collect_slide_variants(variants)
          result += new_result
          variants = new_variants
          break if variants.empty?
        end

        result
      end

      def collect_slide_variants(variants)
        result = []
        new_vars = []
        variants.each do |variant|
          base = list.drop(variant.flatten.size)
          vars = base_variants(base)
          vars.each do |var|
            value = variant + var
            next result << value if value.flatten.size == list.size
            next new_vars << value if value.flatten.size < list.size
          end
        end
        [result, new_vars]
      end

      def base_variants(array)
        return [[]] if array.size.zero?
        return [[array]] if array.size == 1

        variants = []
        1.upto(array.size) do |i|
          variants << [array.take(i)]
        end
        variants
      end
    end
  end
end
