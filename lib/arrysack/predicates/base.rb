# frozen_string_literal: true

module Arrysack
  module Predicates
    class Base
      NAME = ''

      attr_reader :value, :query_value, :options

      def initialize(value, query_value = nil, **options)
        @value = value
        @query_value = query_value
        @options = options
      end

      def symbol
        self.class.symbol
      end

      def suffix
        self.class.suffix
      end

      def rank
        self.class.rank
      end

      def match?
        values_match?
      rescue StandardError => _e
        true
      end

      class << self
        def match?(value, query_value = nil, **options)
          new(value, query_value, **options).match?
        end

        def rank
          self::NAME.size
        end

        def suffix
          "_#{self::NAME}"
        end

        def symbol
          self::NAME
        end

        def register
          Predicates.add self
        end

        def allow?(_type)
          true
        end

        def disallow?(type)
          !allow?(type)
        end
      end

      private

      def values_match?
        true
      end
    end
  end
end
