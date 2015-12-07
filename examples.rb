require './sel/context'
require './sel/evaluator'

context = Context.new
evaluator = Evaluator.new

context.registerValue "name", "RUBY"

context.registerHandler "capitalize", lambda {|arg| arg.capitalize}

puts evaluator.evaluate "Hello $capitalize($name)", context


