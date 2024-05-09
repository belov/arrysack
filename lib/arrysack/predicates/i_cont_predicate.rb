# frozen_string_literal: true

module Arrysack
  module Predicates
    class IContPredicate < Base
      NAME = 'i_cont'
      register

      def values_match?
        item_value.include? query_value.to_s.downcase
      end

      private

      def item_value
        return value.map { |i| i.to_s.downcase } if value.is_a? Array

        value.to_s.downcase
      end
    end
  end
end
