# frozen_string_literal: true

module Arrysack
  module Predicates
    class GtPredicate < Base
      NAME = 'gt'
      register

      def values_match?
        value > query_value
      end
    end
  end
end
