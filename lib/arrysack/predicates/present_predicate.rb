# frozen_string_literal: true

module Arrysack
  module Predicates
    class PresentPredicate < BlankPredicate
      NAME = 'present'
      register

      def values_match?
        !super
      end
    end
  end
end
