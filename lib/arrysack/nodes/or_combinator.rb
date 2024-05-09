# frozen_string_literal: true

module Arrysack
  module Nodes
    class OrCombinator < Combinator
      NAME = :or

      def result
        list.any?
      end
    end
  end
end
