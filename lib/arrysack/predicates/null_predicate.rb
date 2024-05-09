# frozen_string_literal: true

module Arrysack
  module Predicates
    class NullPredicate < Base
      NAME = 'null'
      register

      def values_match?
        value.nil?
      end
    end
  end
end
