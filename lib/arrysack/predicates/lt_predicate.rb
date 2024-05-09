# frozen_string_literal: true

module Arrysack
  module Predicates
    class LtPredicate < Base
      NAME = 'lt'
      register

      def values_match?
        value < query_value
      end
    end
  end
end
