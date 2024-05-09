# frozen_string_literal: true

module Arrysack
  module Predicates
    class ContPredicate < Base
      NAME = 'cont'
      register

      def values_match?
        v = value.is_a?(Array) ? value.flatten : value
        v.include? query_value
      end
    end
  end
end
