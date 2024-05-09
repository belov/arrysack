# frozen_string_literal: true

module Arrysack
  module Predicates
    class BlankPredicate < Base
      using Arrysack::CoreExt

      NAME = 'blank'
      register

      def values_match?
        value.blank?
      end
    end
  end
end
