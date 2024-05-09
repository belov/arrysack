# frozen_string_literal: true

module Arrysack
  module Predicates
    class << self
      def find(name)
        @index[name.to_s]
      end

      alias [] find

      attr_reader :all, :index

      def add(predicate)
        @all ||= []
        @index ||= {}
        @all << predicate
        @all.uniq!
        @all = @all.sort_by(&:rank).reverse
        @index[predicate.symbol.to_s] = predicate
      end
    end
  end
end
