# frozen_string_literal: true

module Arrysack
  module Predicates
    class LteqPredicate < Base
      NAME = 'lteq'
      register

      def values_match?
        value <= query_value
      end
    end
  end
end
