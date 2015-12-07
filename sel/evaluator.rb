require "./sel/context"
require "./sel/parser"



class Evaluator

    RECURSION_LIMIT = 15;

    def initialize
        @globalContext = Context.new
        @parser = Parser.new
    end

    def evaluate expression, context = Context.new
        if context.respond_to? 'incherit' 
            context.incherit @globalContext
        else
            context = @globalContext
        end
        _evaluate expression, context, 0
    end

    
    def _evaluate  expression, context, r_level
        if not expression.is_a? String
            return espression
        end

        if r_level > RECURSION_LIMIT
            raise "SEL: Recursion limit reached" 
        end
        
        occurence = @parser.parse_occurence expression
        while occurence
            argument = nil
            if occurence.is_func
                argument = _evaluate occurence.argument, context, r_level + 1
            end         

            handler = context.getHandlerByName occurence.name
            sub_value = handler.call argument
            if ((not expression.is_a? String) or (expression.length == occurence.full_match.length))
                expression = sub_value
                break
            else
                expression = expression.sub occurence.full_match, sub_value
                occurence = @parser.parse_occurence expression    
            end          
        end

        
        expression
    end
end