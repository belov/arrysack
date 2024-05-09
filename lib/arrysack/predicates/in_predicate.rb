# frozen_string_literal: true

module Arrysack
  module Predicates
    class InPredicate < Base
      using Arrysack::CoreExt

      NAME = 'in'
      register

      def values_match?
        Array.wrap(query_value).include?(value)
      end
    end
  end
end
