# frozen_string_literal: true

module Arrysack
  module Predicates
    class StartPredicate < Base
      NAME = 'start'
      register

      def values_match?
        value.to_s.start_with?(query_value)
      end
    end
  end
end
