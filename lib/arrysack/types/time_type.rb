# frozen_string_literal: true

require 'time'
module Arrysack
  module Types
    class TimeType < Base
      self.type = :time
      self.rank = 80
      class << self
        def match_sample?(sample)
          sample.is_a?(::Time)
        end
      end

      register

      def cast(input)
        return input if input.is_a? Time
        return input.to_time if input.respond_to? :to_time
        return Time.strptime(input, format) if format

        Time.parse(input)
      rescue StandardError
        nil
      end
    end
  end
end
