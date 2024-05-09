# frozen_string_literal: true

module Arrysack
  module Predicates
    class DoesNotMatchPredicate < MatchesPredicate
      NAME = 'does_not_match'
      register

      def values_match?
        !super
      end
    end
  end
end
