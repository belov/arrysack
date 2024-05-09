# frozen_string_literal: true

module Arrysack
  module Types
    class BooleanType < Base
      self.type = :boolean
      self.rank = 100
      class << self
        def match_sample?(sample)
          sample.is_a?(::TrueClass) || sample.is_a?(::FalseClass)
        end
      end

      register

      def cast(input)
        !!input
      end
    end
  end
end
