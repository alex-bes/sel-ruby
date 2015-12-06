require './sel/context'

context = Context.new

context.registerHandler('foo', 'bar')

puts context.handlers

context2 = Context.new

context2.incherit context

puts context2.handlers