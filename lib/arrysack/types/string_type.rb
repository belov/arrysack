# frozen_string_literal: true

module Arrysack
  module Types
    class StringType < Base
      self.type = :string
      self.rank = 90
      class << self
        def match_sample?(sample)
          sample.is_a?(::String)
        end
      end

      register

      def cast(input)
        input.to_s
      end
    end
  end
end
