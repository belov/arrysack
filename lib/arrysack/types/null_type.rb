# frozen_string_literal: true

module Arrysack
  module Types
    class NullType < Base
      self.type = :null
      self.rank = 5
      class << self
        def match_sample?(sample)
          sample.nil?
        end
      end

      register

      def cast(_input)
        nil
      end
    end
  end
end
