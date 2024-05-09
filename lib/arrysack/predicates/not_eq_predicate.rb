# frozen_string_literal: true

module Arrysack
  module Predicates
    class NotEqPredicate < Base
      NAME = 'not_eq'
      register

      def values_match?
        value != query_value
      end
    end
  end
end
