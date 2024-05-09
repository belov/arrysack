# frozen_string_literal: true

module Arrysack
  module Predicates
    class GteqPredicate < Base
      NAME = 'gteq'
      register

      def values_match?
        value >= query_value
      end
    end
  end
end
