# frozen_string_literal: true

module Arrysack
  module Nodes
    class AndCombinator < Combinator
      NAME = :and

      def result
        list.all?
      end
    end
  end
end
