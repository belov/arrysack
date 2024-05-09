# frozen_string_literal: true

module Arrysack
  module Types
    class NumberType < Base
      self.type = :number
      self.rank = 30
      class << self
        def match_sample?(sample)
          sample.is_a?(::Numeric)
        end
      end

      register

      def cast(input)
        input.to_f
      end
    end
  end
end
