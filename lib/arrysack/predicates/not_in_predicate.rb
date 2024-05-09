# frozen_string_literal: true

require_relative 'in_predicate'
module Arrysack
  module Predicates
    class NotInPredicate < InPredicate
      NAME = 'not_in'
      register

      def values_match?
        !super
      end
    end
  end
end
