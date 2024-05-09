# frozen_string_literal: true

module Arrysack
  module Predicates
    class MatchesPredicate < Base
      NAME = 'matches'
      register

      def values_match?
        Regexp.new(query_value).match? value
      end
    end
  end
end
