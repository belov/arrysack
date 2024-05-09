# frozen_string_literal: true

module Arrysack
  module Types
    class IntegerType < Base
      self.type = :integer
      self.rank = 70
      class << self
        def match_sample?(sample)
          sample.is_a?(::Integer)
        end
      end

      register

      def cast(input)
        input.to_i
      end
    end
  end
end
