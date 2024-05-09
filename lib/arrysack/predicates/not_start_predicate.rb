# frozen_string_literal: true

require_relative 'start_predicate'
module Arrysack
  module Predicates
    class NotStartPredicate < StartPredicate
      NAME = 'not_start'
      register

      def values_match?
        !super
      end
    end
  end
end
