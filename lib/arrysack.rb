# frozen_string_literal: true

def require_all(pattern)
  Gem.find_files(pattern).reject { |path| path.include?('/spec/') }.each { |path| require path }
end

require_relative 'arrysack/version'
require_relative 'arrysack/core_ext'

require_relative 'arrysack/array_ext'
require_relative 'arrysack/schema'
require_relative 'arrysack/predicates'
require_relative 'arrysack/predicates/base'
require_relative 'arrysack/predicates/eq_predicate'
require_all('arrysack/predicates/**/*.rb')

require_relative 'arrysack/nodes/combinator'
require_relative 'arrysack/nodes/and_combinator'
require_relative 'arrysack/nodes/or_combinator'
require_relative 'arrysack/nodes/condition'
require_relative 'arrysack/nodes/group'

require_all('arrysack/types/**/*.rb')

module Arrysack
  class Error < StandardError; end

  # Your code goes here...
  ::Array.include(Arrysack::ArrayExt)
end
