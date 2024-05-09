# frozen_string_literal: true

require 'date'
module Arrysack
  module Types
    class DateType < Base
      self.type = :date
      self.rank = 50
      class << self
        def match_sample?(sample)
          sample.is_a?(::Date)
        end
      end

      register

      def cast(input)
        return input if input.is_a? Date
        return input.to_date if input.respond_to? :to_date
        return Date.strptime(input, format) if format

        Date.parse(input)
      rescue StandardError
        nil
      end
    end
  end
end
