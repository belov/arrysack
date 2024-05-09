# frozen_string_literal: true

require 'concurrent/map'

module Arrysack
  module CoreExt
    module Support
      module Object
        module Blank
          refine ::Object do
            # An object is blank if it's false, empty, or a whitespace string.
            # For example, +nil+, '', '   ', [], {}, and +false+ are all blank.
            #
            # This simplifies
            #
            #   !address || address.empty?
            #
            # to
            #
            #   address.blank?
            #
            # @return [true, false]
            def blank?
              respond_to?(:empty?) ? !!empty? : false
            end

            # An object is present if it's not blank.
            #
            # @return [true, false]
            def present?
              !blank?
            end

            # Returns the receiver if it's present otherwise returns +nil+.
            # <tt>object.presence</tt> is equivalent to
            #
            #    object.present? ? object : nil
            #
            # For example, something like
            #
            #   state   = params[:state]   if params[:state].present?
            #   country = params[:country] if params[:country].present?
            #   region  = state || country || 'US'
            #
            # becomes
            #
            #   region = params[:state].presence || params[:country].presence || 'US'
            #
            # @return [Object]
            def presence
              self if present?
            end
          end

          refine ::NilClass do
            # +nil+ is blank:
            #
            #   nil.blank? # => true
            #
            # @return [true]
            def blank?
              true
            end

            def present? # :nodoc:
              false
            end
          end

          refine ::FalseClass do
            # +false+ is blank:
            #
            #   false.blank? # => true
            #
            # @return [true]
            def blank?
              true
            end

            def present? # :nodoc:
              false
            end
          end

          refine ::TrueClass do
            # +true+ is not blank:
            #
            #   true.blank? # => false
            #
            # @return [false]
            def blank?
              false
            end

            def present? # :nodoc:
              true
            end
          end

          refine ::Array do
            # An array is blank if it's empty:
            #
            #   [].blank?      # => true
            #   [1,2,3].blank? # => false
            #
            # @return [true, false]
            alias_method :blank?, :empty?

            def present? # :nodoc:
              !empty?
            end
          end

          refine ::Hash do
            # A hash is blank if it's empty:
            #
            #   {}.blank?                # => true
            #   { key: 'value' }.blank?  # => false
            #
            # @return [true, false]
            alias_method :blank?, :empty?

            def present? # :nodoc:
              !empty?
            end
          end

          refine ::Symbol do
            # A Symbol is blank if it's empty:
            #
            #   :''.blank?     # => true
            #   :symbol.blank? # => false
            alias_method :blank?, :empty?

            def present? # :nodoc:
              !empty?
            end
          end

          refine ::String.singleton_class do
            def _blank_re
              @_blank_re ||= /\A[[:space:]]*\z/
            end

            def _encoded_blanks
              @_encoded_blanks ||= Concurrent::Map.new do |h, enc|
                h[enc] = Regexp.new(_blank_re.source.encode(enc), _blank_re.options | Regexp::FIXEDENCODING)
              end
            end
          end

          refine ::String do
            # A string is blank if it's empty or contains whitespaces only:
            #
            #   ''.blank?       # => true
            #   '   '.blank?    # => true
            #   "\t\n\r".blank? # => true
            #   ' blah '.blank? # => false
            #
            # Unicode whitespace is supported:
            #
            #   "\u00a0".blank? # => true
            #
            # @return [true, false]
            def blank?
              # The regexp that matches blank strings is expensive. For the case of empty
              # strings we can speed up this method (~3.5x) with an empty? call. The
              # penalty for the rest of strings is marginal.
              empty? ||
                begin
                  self.class._blank_re.match?(self)
                rescue Encoding::CompatibilityError
                  self.class._encoded_blanks[encoding].match?(self)
                end
            end

            def present? # :nodoc:
              !blank?
            end
          end

          refine ::Numeric do
            # No number is blank:
            #
            #   1.blank? # => false
            #   0.blank? # => false
            #
            # @return [false]
            def blank?
              false
            end

            def present?
              true
            end
          end

          refine ::Time do
            # No Time is blank:
            #
            #   Time.now.blank? # => false
            #
            # @return [false]
            def blank?
              false
            end

            def present?
              true
            end
          end
        end
      end
    end
  end
end
