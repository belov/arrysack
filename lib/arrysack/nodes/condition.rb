# frozen_string_literal: true

require_relative '../item_value'
module Arrysack
  module Nodes
    class Condition
      using Arrysack::CoreExt

      attr_reader :methods_chain, :predicate, :query_value

      def initialize(predicate, methods_chain, query_value)
        @predicate = find_predicate(predicate)
        @methods_chain = Array.wrap(methods_chain)
        @query_value = query_value
      end

      def valid?
        !!(methods_chain && predicate)
      end

      def invalid?
        !valid?
      end

      def result(item)
        predicate.match?(item_value(item), query_value)
      end

      private

      def find_predicate(name_or_predicate)
        return name_or_predicate if name_or_predicate.is_a?(Class) && name_or_predicate < Arrysack::Predicates::Base

        Arrysack::Predicates.find(name_or_predicate)
      end

      def item_value(item)
        Arrysack::ItemValue.new(item, methods_chain).extract
      end
    end
  end
end
