# frozen_string_literal: true

module Arrysack
  module Predicates
    class TruePredicate < Base
      NAME = 'true'
      register

      def values_match?
        value == true
      end
    end
  end
end
