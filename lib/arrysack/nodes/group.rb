# frozen_string_literal: true

module Arrysack
  module Nodes
    class Group
      attr_accessor :combinator

      def initialize(combinator: nil, children: [], conditions: [])
        @combinator = Combinator.build(combinator)
        @children = children || []
        @conditions = conditions || []
      end

      def valid?
        return false unless combinator
        return false if children.empty? && conditions.empty?

        conditions_valid? && children_valid?
      end

      def invalid?
        !valid?
      end

      def sanitize!
        children.delete_if(&:invalid?)
        conditions.delete_if(&:invalid?)

        self
      end

      def result(item)
        values = children.map { |group| group.result(item) }
        values += conditions.map { |condition| condition.result(item) }
        combinator.result(values)
      end

      def push(child)
        return unless child
        return if child.respond_to?(:invalid?) && child.invalid?

        if child.is_a?(Group)
          @children << child
          return child
        end

        return unless child.is_a?(Condition)

        @conditions << child
        child
      end

      alias << push

      def to_simple
        result = {}
        children.select(&:valid?).each do |g|
          result.merge!(g.to_simple)
        end

        if or_simple_query?
          result.merge!(or_simple_query)
        else
          result.merge!(and_simple_query)
        end

        result
      end

      private

      attr_accessor :children, :conditions

      def or_simple_query?
        combinator == OrCombinator &&
          conditions.map(&:query_value).uniq.size == 1 &&
          conditions.map(&:predicate).uniq.size == 1
      end

      def or_simple_query
        attrs = conditions.select(&:valid?).map do |c|
          c.attribute.join('-')
        end
        key = attrs.join(OrCombinator.splitter)
        { key => conditions.first&.query_value }
      end

      def and_simple_query
        conditions.each_with_object({}) do |c, result|
          key = "#{c.attribute.join("_")}_#{c.predicate.symbol}"
          result.merge!({ key => c.query_value })
        end
      end

      def children_valid?
        children.all?(&:valid?)
      end

      def conditions_valid?
        conditions.all?(&:valid?)
      end
    end
  end
end
