# frozen_string_literal: true

require_relative 'i_cont_predicate'
module Arrysack
  module Predicates
    class NotIContPredicate < IContPredicate
      NAME = 'not_i_cont'
      register

      def values_match?
        !super
      end
    end
  end
end
