# frozen_string_literal: true

require_relative 'null_predicate'
module Arrysack
  module Predicates
    class NotNullPredicate < NullPredicate
      NAME = 'not_null'
      register

      def values_match?
        !super
      end
    end
  end
end
