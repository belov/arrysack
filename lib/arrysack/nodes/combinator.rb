# frozen_string_literal: true

module Arrysack
  module Nodes
    class Combinator
      NAME = nil
      attr_reader :list

      def initialize(list)
        @list = *list
      end

      def symbol
        self.class.symbol
      end

      def result
        true
      end

      def splitter
        self.class.splitter
      end

      class << self
        def result(list)
          new(list).result
        end

        def symbol
          self::NAME
        end

        def splitter
          "_#{symbol}_"
        end

        def all
          [AndCombinator, OrCombinator]
        end

        def index
          @index ||= all.each_with_object({}) { |combinator, h| h[combinator.symbol.to_s] = combinator }
        end

        def build(name)
          return name if name.is_a?(Class) && (name < self)

          combinator = index[name.to_s]
          combinator || AndCombinator
        end
      end
    end
  end
end
