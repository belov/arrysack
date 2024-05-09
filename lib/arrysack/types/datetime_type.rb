# frozen_string_literal: true

require_relative 'time_type'
module Arrysack
  module Types
    class DatetimeType < TimeType
      self.type = :datetime
      self.rank = 60
      class << self
        def match_sample?(sample)
          sample.is_a?(::DateTime)
        end
      end

      register
    end
  end
end
