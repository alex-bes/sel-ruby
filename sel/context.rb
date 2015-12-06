class Context
    
    attr_reader :handlers
    
    def initialize
        @handlers = Hash.new
    end
    
    def registerHandler name, handler
        @handlers[name] = handler
    end

    def registerValue name, value
	   @handlers[name] = value #TODO: wrap value into function 
    end

    def unregisterHandler name
        @handlers.delete(name)
    end

    def getHandlerByName name
        @handlers[name]
    end
    
    def incherit context
        parentHandlers = context.handlers
        parentHandlers.each do |name, handler|
           @handlers[name] = handler
        end
    end

end
