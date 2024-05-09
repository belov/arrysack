# frozen_string_literal: true

module Arrysack
  module Predicates
    class FalsePredicate < Base
      NAME = 'false'
      register

      def values_match?
        value == false
      end
    end
  end
end
