# frozen_string_literal: true

require_relative 'end_predicate'
module Arrysack
  module Predicates
    class NotEndPredicate < EndPredicate
      NAME = 'not_end'
      register

      def values_match?
        !super
      end
    end
  end
end
