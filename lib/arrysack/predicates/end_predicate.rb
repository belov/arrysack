# frozen_string_literal: true

module Arrysack
  module Predicates
    class EndPredicate < Base
      NAME = 'end'
      register

      def values_match?
        value.to_s.end_with?(query_value)
      end
    end
  end
end
