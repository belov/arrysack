# frozen_string_literal: true

module Arrysack
  module Predicates
    class EqPredicate < Base
      NAME = 'eq'
      register

      def values_match?
        value == query_value
      end
    end
  end
end
